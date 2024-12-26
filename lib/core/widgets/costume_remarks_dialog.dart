import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../app_managers/color_manager.dart';

class CostumeRemarksDialog extends StatefulWidget {
  final bool cancelable;
  final Function(String remarks,String payType,String bankOrWalletName,String chequeOrMobileNo)? onButton1Clicked;

  const CostumeRemarksDialog({
    super.key,
    this.cancelable = false,
    this.onButton1Clicked,
  });

  @override
  State<CostumeRemarksDialog> createState() => _CostumeRemarksDialogState();
}

TextEditingController remarksController = TextEditingController();
TextEditingController chequeOrMobileNoController = TextEditingController();

final TextEditingController paymentOptionController = TextEditingController();
final TextEditingController walletController = TextEditingController();
final TextEditingController bankController = TextEditingController();

PaymentOptions? selectedPaymentOption;
Wallets? selectedWallet;

class _CostumeRemarksDialogState extends State<CostumeRemarksDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (widget.cancelable) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Complete Actions",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Gap(12),
                      DropdownMenu<PaymentOptions>(
                        width: double.infinity,
                        controller: paymentOptionController,
                        requestFocusOnTap: false,
                        enableFilter: false,
                        enableSearch: false,
                        label: const Text('Payment Options'),
                        onSelected: (PaymentOptions? paymentOptions) {
                          setState(() {
                            selectedPaymentOption = paymentOptions;
                          });
                        },
                        dropdownMenuEntries: PaymentOptions.entries,
                      ),

                      Visibility(
                        visible: selectedPaymentOption?.label == "Wallet",
                        child: Column(
                          children: [
                            const Gap(12),
                            DropdownMenu<Wallets>(
                              width: double.infinity,
                              controller: walletController,
                              requestFocusOnTap: false,
                              enableFilter: false,
                              enableSearch: false,
                              label: const Text('Select Wallet'),
                              onSelected: (Wallets? wallet) {
                                setState(() {
                                  selectedWallet = wallet;
                                });
                              },
                              dropdownMenuEntries: Wallets.entries,
                            ),
                          ],
                        ),
                      ),

                      // Visibility(
                      //   visible: selectedPaymentOption?.label == "Bank",
                      //   child: Column(
                      //     children: [
                      //       const Gap(12),
                      //       DropdownMenu<BanksTypes>(
                      //         width: double.infinity,
                      //         controller: bankTypeController,
                      //         requestFocusOnTap: false,
                      //         enableFilter: false,
                      //         enableSearch: false,
                      //         label: const Text('Transfer Type'),
                      //         onSelected: (BanksTypes? types) {
                      //           setState(() {
                      //             selectedBankType = types;
                      //           });
                      //         },
                      //         dropdownMenuEntries: BanksTypes.entries,
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Visibility(
                        visible: selectedPaymentOption != null &&
                            selectedPaymentOption?.label == "Bank",
                        child: Column(
                          children: [
                            const Gap(12),
                            Column(
                              children: [
                                TextField(
                                  controller: bankController,
                                  maxLines: 1, //or null
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.textDark,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.errorOpacity50,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      labelText: 'Bank Name',
                                      hintText: "Enter bank name"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: selectedPaymentOption != null &&
                            selectedPaymentOption?.label != "Cash",
                        child: Column(
                          children: [
                            const Gap(12),
                            Column(
                              children: [
                                TextField(
                                  controller: chequeOrMobileNoController,
                                  maxLines: 1, //or null
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.textDark,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                                  .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.errorOpacity50,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      labelText: selectedPaymentOption?.label ==
                                              'Wallet'
                                          ? 'Mobile No.'
                                          : 'Cheque/Mobile No.',
                                      hintText: selectedPaymentOption?.label ==
                                              'Wallet'
                                          ? 'Mobile No.'
                                          : 'Cheque/Mobile No.'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Gap(12),
                      Column(
                        children: [
                          TextField(
                            controller: remarksController,
                            maxLines: 2, //or null
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.textDark,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.1)),
                                    borderRadius: BorderRadius.circular(6)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.errorOpacity50,
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                labelText: 'Remarks',
                                hintText: "Enter your remarks here"),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ElevatedButton(
                                      onPressed: (widget.onButton1Clicked) !=
                                              null
                                          ? () {
                                              Navigator.pop(context);
                                              String remarks = remarksController
                                                      .text.isNotEmpty
                                                  ? remarksController.text
                                                  : "-";

                                              String bankOrWalletName ="";
                                              if(selectedPaymentOption?.label=='Bank'){
                                                bankOrWalletName = bankController.text.toString();
                                              }
                                              if(selectedPaymentOption?.label=='Wallet'){
                                                bankOrWalletName = selectedWallet?.label??"";
                                              }

                                              widget.onButton1Clicked!(remarks,selectedPaymentOption?.label??"",bankOrWalletName,chequeOrMobileNoController.text);
                                            }
                                          : () {
                                              Navigator.pop(context);
                                            },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          backgroundColor: Colors.green),
                                      child: const Padding(
                                        padding: EdgeInsets.all(14),
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef PaymentOptionsEntry = DropdownMenuEntry<PaymentOptions>;
typedef WalletsEntry = DropdownMenuEntry<Wallets>;
// typedef BanksEntry = DropdownMenuEntry<BanksTypes>;

enum PaymentOptions {
  cash('Cash', Icons.payments_outlined),
  bank('Bank', Icons.account_balance_outlined),
  wallet('Wallet', Icons.account_balance_wallet_outlined);

  const PaymentOptions(this.label, this.icon);

  final String label;
  final IconData icon;

  static final List<PaymentOptionsEntry> entries =
      UnmodifiableListView<PaymentOptionsEntry>(
    values.map<PaymentOptionsEntry>(
      (PaymentOptions icon) => PaymentOptionsEntry(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
}

enum Wallets {
  esewa('eSewa'),
  khalti('Khalti'),
  imepay('ImePay'),
  others('Others');

  const Wallets(this.label);

  final String label;

  static final List<WalletsEntry> entries = UnmodifiableListView<WalletsEntry>(
    values.map<WalletsEntry>(
      (Wallets wallets) => WalletsEntry(
        value: wallets,
        label: wallets.label,
      ),
    ),
  );
}

// enum BanksTypes {
//   cheque('Cheque'),
//   transfer('Transfer');
//
//   const BanksTypes(this.label);
//
//   final String label;
//
//   static final List<BanksEntry> entries = UnmodifiableListView<BanksEntry>(
//     values.map<BanksEntry>(
//       (BanksTypes types) => BanksEntry(
//         value: types,
//         label: types.label,
//       ),
//     ),
//   );
// }
