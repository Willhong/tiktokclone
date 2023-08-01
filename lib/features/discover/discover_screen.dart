import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclone/constants/sizes.dart';

import '../../constants/gaps.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController =
      TextEditingController(text: "Initial Text");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print("submitted: $value");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            title: SizedBox(
              height: Sizes.size40,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _searchController.clear();
                          },
                          splashRadius: 1,
                          icon: const FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            size: Sizes.size16,
                            color: Colors.black54,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                      onChanged: _onSearchChanged,
                      onSubmitted: _onSearchSubmitted,
                      controller: _searchController,
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              onTap: (index) {
                FocusScope.of(context).unfocus();
              },
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
              indicatorColor: Colors.black,
              tabs: [
                for (final tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(Sizes.size6),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size8,
                  mainAxisSpacing: Sizes.size8,
                  childAspectRatio: 9 / 21,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: 'assets/image/placeholder.png',
                              image:
                                  "https://images.pexels.com/photos/11631892/pexels-photo-11631892.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load"),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "This is very long caption for my tiktok that im upload just now currently.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.size16 + Sizes.size2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v8,
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: Sizes.size14,
                          color: Colors.grey.shade500,
                        ),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 15,
                              child: Text("경택"),
                            ),
                            Gaps.h10,
                            Expanded(
                              child: Text(
                                "My avatar is going to be very long",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size14,
                            ),
                            Gaps.h2,
                            Text(
                              '2.5M',
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
                itemCount: 20,
              ),
              for (final tab in tabs.skip(1))
                Center(
                  child: Text(tab),
                ),
            ],
          )),
    );
  }
}
