import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kukbook/core/common/widgets/custom_text_input.dart';
import 'package:kukbook/core/common/widgets/custom_text_widget.dart';
import 'package:kukbook/features/auth/controller/auth_controller.dart';
import 'package:kukbook/theme/palette.dart';

import '../../../core/common/widgets/text_input_field_2.dart';
import '../../../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          return CustomTextWidget(
                            text:
                                'Hi ${ref.watch(userProvider)?.name.split(' ').first ?? ""}',
                            weight: FontWeight.w700,
                            fontSizeMultiplier: 0.05,
                          );
                        }),
                        const CustomTextWidget(
                          text: "Let's make a Delish",
                          weight: FontWeight.w700,
                          fontSizeMultiplier: 0.05,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: w * 0.16,
                    width: w * 0.16,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Palette.greyColor,
                          Palette.greyColor.withOpacity(0.3)
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Palette.primaryColor),
                    ),
                    child: Consumer(builder: (context, ref, child) {
                      return ref.watch(userProvider)?.profilePic == null
                          ? Icon(
                              Icons.person,
                              size: w * 0.1,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(w * 0.1),
                              child: Image(
                                  image: NetworkImage(
                                      ref.watch(userProvider)!.profilePic)),
                            );
                    }),
                  )
                ],
              ),
              SizedBox(
                height: w * 0.05,
              ),
              CustomTextInput2(
                controller: searchController,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: w * 0.05),
                  child: Icon(
                    Icons.search,
                    color: Palette.primaryColor,
                    size: w * 0.08,
                  ),
                ),
                hintText: 'Search Recipes, Cuisines, Diets',
              ),
              SizedBox(
                height: w * 0.05,
              ),
              Center(
                child: Container(
                  width: w * 0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(w * 0.01),
                    color: const Color(0xfffff7f2),
                    border: Border.all(
                        color: Palette.primaryColor, width: w * 0.0014),
                  ),
                  padding: EdgeInsets.symmetric(vertical: w * 0.03),
                  child: const Center(
                    child: CustomTextWidget(
                      text: 'COOK WITH WHAT I HAVE',
                      fontSizeMultiplier: 0.029,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: w * 0.03),
                child: const CustomTextWidget(
                  text: 'Cuisine',
                  fontSizeMultiplier: 0.04,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
