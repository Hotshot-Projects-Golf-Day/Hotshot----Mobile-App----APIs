import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:upd8s/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.emailAddress,
    this.heading,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.maxLength,
    this.isPassword = false,
  });

  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final String? heading;
  final int maxLines;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading != null) ...[
          Text(
            widget.heading!,
            style: const TextStyle(
              fontFamily: 'Aptos',
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1.0,
              letterSpacing: -0.055,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],

        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? obscure : false,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,

          autovalidateMode: AutovalidateMode.onUserInteraction,

          style: const TextStyle(
            fontFamily: 'Aptos',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),

          validator: widget.validator,

          decoration: InputDecoration(
            filled: true,
            hintText: widget.labelText,
            alignLabelWithHint: true,
            hintStyle: const TextStyle(
              fontFamily: 'Aptos',
              fontSize: 14,
              fontWeight: FontWeight.w100,
              color: AppColor.natural40,
            ),
            fillColor: AppColor.natural3,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.primaryColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                : null,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.transparent),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.transparent),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.red),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomMobileTextField extends StatefulWidget {
  const CustomMobileTextField({
    super.key,
    this.labelText,
    this.controller,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.heading,
    this.onCountryChanged,
    this.isRequired = false,
  });

  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?, Country)? validator;
  final bool enabled;
  final bool readOnly;
  final String? heading;
  final void Function(Country)? onCountryChanged;
  final bool isRequired;

  @override
  State<CustomMobileTextField> createState() => _CustomMobileTextFieldState();
}

class _CustomMobileTextFieldState extends State<CustomMobileTextField> {
  Country selectedCountry = Country(
    phoneCode: '95',
    countryCode: 'MM',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Myanmar',
    example: '912345678',
    displayName: 'Myanmar',
    displayNameNoCountryCode: 'Myanmar',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Heading + Asterisk
        if (widget.heading != null) ...[
          Text(
            widget.heading!,
            style: const TextStyle(
              fontFamily: 'Aptos',
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1.0,
              letterSpacing: -0.055,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],

        /// Mobile Field
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          style: Theme.of(context).textTheme.bodyMedium,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          /// Validation Logic
          validator: (value) {
            if (widget.isRequired && (value == null || value.trim().isEmpty)) {
              return "${widget.heading ?? 'Mobile number'} is required";
            }

            if (widget.validator != null) {
              return widget.validator!(value, selectedCountry);
            }

            return null;
          },

          decoration: InputDecoration(
            filled: true,
            hintText: widget.labelText ?? 'Mobile Number',
            hintStyle: const TextStyle(
              fontFamily: 'Aptos',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColor.natural40,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),

            /// Country Picker Prefix
            prefixIcon: InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (Country country) {
                    setState(() {
                      selectedCountry = country;
                    });
                    widget.onCountryChanged?.call(country);
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '+${selectedCountry.phoneCode}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.transparent),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.transparent),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1.0,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.red),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(38),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    this.heading,
    this.hintText,
    this.value,
    required this.items,
    this.onChanged,
    this.validator,
  });

  final String? heading;
  final String? hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null) ...[
          Text(
            heading!,
            style: const TextStyle(
              fontFamily: 'Aptos',
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1.0,
              letterSpacing: -0.055,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],

        FormField<String>(
          validator: validator,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    valueListenable: ValueNotifier(value),
                    hint: Text(
                      hintText ?? "Select",
                      style: const TextStyle(
                        fontFamily: 'Aptos',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColor.natural40,
                      ),
                    ),

                    items: items
                        .map(
                          (item) => DropdownItem<String>(
                            value: item,
                            height: 45,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontFamily: 'Aptos',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                        .toList(),

                    onChanged: (val) {
                      state.didChange(val);
                      onChanged?.call(val);
                    },

                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(38),
                        color: Colors.white,
                        border: Border.all(
                          color: state.hasError
                              ? Colors.red
                              : Colors.transparent,
                        ),
                      ),
                    ),

                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 22,
                      iconEnabledColor: Colors.black54,
                    ),

                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                    ),

                    menuItemStyleData: const MenuItemStyleData(
                      // height: 45,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),

                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 12),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
