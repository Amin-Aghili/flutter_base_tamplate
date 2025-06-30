import 'package:flutter_base_template/models/shop_info_model.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/screens/dashboard/components/todo_card.dart';
import 'package:flutter_base_template/services/shop_info_service.dart';
import 'package:flutter_base_template/utils/format.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/shop.dart';
import '../../../ui/components/my_text_field.dart';

class MyFields extends StatelessWidget {
  const MyFields({
    this.shopInfo,
    super.key,
  });
  final ShopInfoModel? shopInfo;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final shopInfoService = Provider.of<ShopInfoService>(context);

    if (shopInfoService.shopInfo == null) {
      Provider.of<ShopInfoService>(context, listen: false).getShopInfo();
      return Column(
        children: [
          SizedBox(height: defaultPadding),
          Responsive(
            mobile: FileInfoCardGridView(
              crossAxisCount: size.width < 650 ? 2 : 4,
              childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 1,
              isPlaceholder: true,
            ),
            tablet: FileInfoCardGridView(isPlaceholder: true),
            desktop: FileInfoCardGridView(
              childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
              isPlaceholder: true,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isPlaceholder = false,
  });

  final int crossAxisCount;
  final double childAspectRatio;
  final bool isPlaceholder;

  @override
  Widget build(BuildContext context) {
    final shopInfoService = Provider.of<ShopInfoService>(context);
    final TextEditingController controller = TextEditingController();

    final List<Todo> todosList = isPlaceholder
        ? List.generate(
            4,
            (index) => Todo(
              title: "",
              numOfTodo: "",
              svgSrc: "",
              color: Colors.transparent,
              fieldName: "",
            ),
          )
        : [
            Todo(
              title: "نرخ لیر",
              numOfTodo: formatNumber(shopInfoService.shopInfo!.liraPrice!),
              svgSrc: "assets/icons/one_drive.svg",
              color: primaryColor,
              fieldName: "lira_price",
            ),
            Todo(
              title: 'نرخ باربری',
              numOfTodo:
                  formatNumber(shopInfoService.shopInfo!.transportPrice!),
              svgSrc: "assets/icons/xd_file.svg",
              color: primaryColor,
              fieldName: 'transport_price',
            ),
            Todo(
              title: "نرخ نرمال",
              numOfTodo: formatNumber(shopInfoService.shopInfo!.normalRate!),
              svgSrc: "assets/icons/Documents.svg",
              color: primaryColor,
              fieldName: 'normal_rate',
            ),
            Todo(
              title: "نرخ ادمین",
              numOfTodo: formatNumber(shopInfoService.shopInfo!.specialRate!),
              svgSrc: "assets/icons/Documents.svg",
              color: primaryColor,
              fieldName: "special_rate",
            ),
          ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: todosList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        final todo = todosList[index];
        final isFieldLoading = isPlaceholder
            ? false
            : shopInfoService.isFieldLoading(todo.fieldName!);
        return TodoCard(
          todos: todo,
          isLoading: isFieldLoading,
          isPlaceholder: isPlaceholder,
          onTab: isPlaceholder || isFieldLoading
              ? null
              : () async => _dialog(
                    context,
                    controller,
                    todo.title!,
                    todo.fieldName!,
                    todo.numOfTodo!,
                  ),
        );
      },
    );
  }

  void _dialog(context, TextEditingController controller, String title,
      String fieldName, String num) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: MyTextField(
            type: TextInputType.number,
            hintText: num,
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('لغو'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ShopInfoService>(context, listen: false)
                    .updateShopInfo(
                  fieldName: fieldName,
                  newValue: parsedNumber(controller.text),
                );
                Navigator.of(context).pop();
              },
              child: Text('تایید'),
            ),
          ],
        );
      },
    );
  }
}
