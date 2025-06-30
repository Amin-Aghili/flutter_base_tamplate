import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/models/payment_model.dart';
import 'package:flutter_base_template/models/shop.dart';
import 'package:flutter_base_template/screens/order_management/components/header.dart';
import 'package:flutter_base_template/screens/order_management/components/my_tab_bar.dart';
import 'package:flutter_base_template/services/order_service.dart';
import 'package:flutter_base_template/services/payment_service.dart';
import 'package:provider/provider.dart';
import 'components/selection_bar.dart';
import 'components/tab_content.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _selectedOrderDetailsId = <int>{};
  final _searchController = TextEditingController();
  List<OrderModel> _filteredOrders = [];
  List<PaymentModel> _filteredPayments = [];

  static const _tabColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.blue,
    Colors.green,
  ];
  static const _tabIcons = [
    Icons.shopping_cart,
    Icons.add_shopping_cart_rounded,
    Icons.call_received,
    Icons.send_rounded,
    Icons.local_post_office_outlined,
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: ShippingSteps.values.length, vsync: this)
          ..addListener(_fetchData);
    _fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.removeListener(_fetchData);
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    final index = _tabController.index;
    try {
      if (index == 0) {
        await Provider.of<PaymentService>(context, listen: false)
            .getUnconfirmedPayments();
      } else {
        await Provider.of<OrderService>(context, listen: false)
            .fetchOrdersByStatus(index);
      }
      if (mounted) {
        setState(() {
          _filteredOrders =
              Provider.of<OrderService>(context, listen: false).ordersByStatus;
          _filteredPayments =
              Provider.of<PaymentService>(context, listen: false)
                  .unconfirmedPayments;
        });
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  void _performSearch(String query) {
    final List<OrderModel> allOrders =
        Provider.of<OrderService>(context, listen: false).ordersByStatus;
    final List<PaymentModel> allPayments =
        Provider.of<PaymentService>(context, listen: false).unconfirmedPayments;

    setState(() {
      if (_tabController.index == 0) {
        if (query.isEmpty) {
          _filteredPayments = allPayments;
        } else {
          _filteredPayments = allPayments.where((payment) {
            return (payment.paymentId?.toString().contains(query) ?? false) ||
                (payment.name?.toLowerCase().contains(query.toLowerCase()) ??
                    false) ||
                (payment.amount?.toString().contains(query) ?? false);
          }).toList();
          debugPrint('Filtered payments: $_filteredPayments');
        }
      } else {
        if (query.isEmpty) {
          _filteredOrders = allOrders;
        } else {
          _filteredOrders = allOrders.where((order) {
            return order.orderDetailId.toString().contains(query) ||
                order.memberName!.toLowerCase().contains(query.toLowerCase()) ||
                order.productUrl!.contains(query);
          }).toList();
          debugPrint('Filtered orders: $_filteredOrders');
        }
      }
      _selectedOrderDetailsId.clear();
    });
  }

  void _toggleSelection(int id) => setState(() {
        _selectedOrderDetailsId.contains(id)
            ? _selectedOrderDetailsId.remove(id)
            : _selectedOrderDetailsId.add(id);
      });

  void _clearSelection() => setState(() => _selectedOrderDetailsId.clear());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Header(
          searchController: _searchController,
          onChanged: _performSearch,
        ),
        if (_selectedOrderDetailsId.isNotEmpty)
          SelectionBar(
            selectedId: _selectedOrderDetailsId,
            orderList: _filteredOrders,
            currentStep: _tabController.index,
            totalSteps: ShippingSteps.values.length,
            onSelectAll: () => setState(() => _selectedOrderDetailsId
                .addAll(_filteredOrders.map((e) => e.orderDetailId!))),
            onDeselectAll: _clearSelection,
            onMovePrevious: _clearSelection,
            onMoveNext: _clearSelection,
          )
        else
          MyTabBar(
            tabColors: _tabColors,
            tabController: _tabController,
            iconData: _tabIcons,
          ),
        Expanded(
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            color: Theme.of(context).colorScheme.tertiary,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: _fetchData,
            // notificationPredicate: (n) => n.depth == 1,
            notificationPredicate: (ScrollNotification notification) {
              return notification.depth == 1;
            },
            child: TabContent(
              tabController: _tabController,
              payments: _filteredPayments,
              orders: _filteredOrders,
              // isPaymentLoading: paymentService.isLoading,
              // isOrderLoading: orderService.isLoading,
              isPaymentLoading: false,
              isOrderLoading: false,
              selectedIds: _selectedOrderDetailsId,
              onToggleSelection: _toggleSelection,
            ),
          ),
        ),
      ],
    );
  }
}
