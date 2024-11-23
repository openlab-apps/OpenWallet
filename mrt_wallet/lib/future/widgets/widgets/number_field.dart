import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrt_wallet/app/core.dart'
    show APPConst, BigIntVoid, BoolVoid, DynamicVoid, IntVoid, StringVoid;
import 'package:mrt_wallet/app/models/models/typedef.dart'
    show NullStringString;
import 'package:mrt_wallet/future/text_field/input_formaters.dart';
import 'constraints_box_view.dart';
import 'paste_icon_widget.dart';
import 'widget_constant.dart';
import 'package:mrt_wallet/future/state_managment/state_managment.dart';

class NumberTextField extends StatefulWidget {
  const NumberTextField({
    super.key,
    required this.label,
    required this.onChange,
    this.padding = WidgetConstant.paddingVertical8,
    this.helperText,
    this.hintText,
    this.error,
    this.validator,
    this.defaultValue,
    required this.max,
    required this.min,
    this.focusNode,
    this.nextFocus,
    this.disableWriting = false,
    this.showPasteIcon = false,
  });
  final bool showPasteIcon;
  final int min;
  final int? max;
  final EdgeInsets padding;
  final String label;
  final String? helperText;
  final String? hintText;
  final String? error;
  final NullStringString? validator;
  final IntVoid onChange;
  final int? defaultValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool disableWriting;
  @override
  State<NumberTextField> createState() => NumberTextFieldState();
}

class NumberTextFieldState extends State<NumberTextField> with SafeState {
  bool add = false;
  bool minus = false;

  final TextEditingController controller = TextEditingController(text: "");
  void _add(bool isAdd) {
    int index = int.parse(controller.text);
    if (isAdd) {
      if (widget.max != null && index >= widget.max!) {
        index = widget.max!;
      } else {
        index++;
      }
    } else {
      if (index <= widget.min) {
        index = widget.min;
      } else {
        index--;
      }
    }
    controller.text = index.toString();
  }

  void onTap(bool isAdd) {
    _add(isAdd);
  }

  Timer? _timer;
  void onLongPress(bool isAdd) {
    if (isAdd) {
      add = true;
    } else {
      minus = true;
    }
    _add(isAdd);
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _add(isAdd);
    });
    setState(() {});
  }

  void onLongPressCancel() {
    add = false;
    minus = false;
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  void onSubmitField(String v) {
    if (widget.nextFocus != null) {
      if (mounted) widget.nextFocus?.requestFocus();
    }
  }

  void listener() {
    final value =
        controller.text.isEmpty ? widget.min : int.parse(controller.text);
    widget.onChange(value);
  }

  void changeIndex(int newIndex) {
    if (newIndex < widget.min ||
        (widget.max != null && newIndex > widget.max!)) {
      return;
    }
    controller.text = "$newIndex";
  }

  void setValue(int newIndex) {
    controller.text = "$newIndex";
  }

  int? getValue() {
    return int.tryParse(controller.text);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);

    Future.delayed(Duration.zero, () {
      changeIndex(widget.defaultValue ?? widget.min);
    });
  }

  void onPaste(String v) {
    controller.text = v;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _NumberTextFieldView(
      padding: widget.padding,
      minus: minus,
      onLongPressCancel: onLongPressCancel,
      onTap: onTap,
      onLongPress: onLongPress,
      controller: controller,
      showPasteIcon: widget.showPasteIcon,
      allowSign: widget.min.isNegative,
      disableWriting: widget.disableWriting,
      error: widget.error,
      focusNode: widget.focusNode,
      helperText: widget.helperText,
      hintText: widget.hintText,
      label: widget.label,
      validator: widget.validator,
      add: add,
      onSubmitField: onSubmitField,
      onPaste: onPaste,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        RangeTextInputFormatter(min: widget.min, max: widget.max)
      ],
    );
  }
}

class BigNumberTextField extends StatefulWidget {
  const BigNumberTextField({
    super.key,
    required this.label,
    required this.onChange,
    this.padding = WidgetConstant.paddingVertical8,
    this.helperText,
    this.hintText,
    this.error,
    this.validator,
    this.defaultValue,
    required this.max,
    required this.min,
    this.focusNode,
    this.nextFocus,
    this.disableWriting = false,
    this.showPasteIcon = false,
  });
  final bool showPasteIcon;
  final BigInt min;
  final BigInt? max;
  final EdgeInsets padding;
  final String label;
  final String? helperText;
  final String? hintText;
  final String? error;
  final NullStringString? validator;
  final BigIntVoid onChange;
  final BigInt? defaultValue;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool disableWriting;
  @override
  State<BigNumberTextField> createState() => BigNumberTextFieldState();
}

class BigNumberTextFieldState extends State<BigNumberTextField> with SafeState {
  bool add = false;
  bool minus = false;

  final TextEditingController _controller = TextEditingController(text: "");
  void _add(bool isAdd) {
    BigInt index = BigInt.parse(_controller.text);
    if (isAdd) {
      if (widget.max != null && index >= widget.max!) {
        index = widget.max!;
      } else {
        index += BigInt.one;
      }
    } else {
      if (index <= widget.min) {
        index = widget.min;
      } else {
        index -= BigInt.one;
      }
    }
    _controller.text = index.toString();
  }

  void onTap(bool isAdd) {
    _add(isAdd);
  }

  Timer? _timer;
  void onLongPress(bool isAdd) {
    if (isAdd) {
      add = true;
    } else {
      minus = true;
    }
    _add(isAdd);
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _add(isAdd);
    });
    setState(() {});
  }

  void onLongPressCancel() {
    add = false;
    minus = false;
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  void onSubmitField(String v) {
    if (widget.nextFocus != null) {
      if (mounted) widget.nextFocus?.requestFocus();
    }
  }

  void listener() {
    final value =
        _controller.text.isEmpty ? widget.min : BigInt.parse(_controller.text);
    widget.onChange(value);
  }

  void changeIndex(BigInt newIndex) {
    if (newIndex < widget.min ||
        (widget.max != null && newIndex > widget.max!)) {
      return;
    }
    _controller.text = "$newIndex";
  }

  void setValue(BigInt newIndex) {
    _controller.text = newIndex.toString();
  }

  BigInt? getValue() {
    return BigInt.tryParse(_controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(listener);

    Future.delayed(Duration.zero, () {
      changeIndex(widget.defaultValue ?? widget.min);
    });
  }

  void onPaste(String v) {
    _controller.text = v;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _controller.removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _NumberTextFieldView(
      padding: widget.padding,
      minus: minus,
      onLongPressCancel: onLongPressCancel,
      onTap: onTap,
      onLongPress: onLongPress,
      controller: _controller,
      showPasteIcon: widget.showPasteIcon,
      allowSign: widget.min.isNegative,
      disableWriting: widget.disableWriting,
      error: widget.error,
      focusNode: widget.focusNode,
      helperText: widget.helperText,
      hintText: widget.hintText,
      label: widget.label,
      validator: widget.validator,
      add: add,
      onSubmitField: onSubmitField,
      onPaste: onPaste,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        BigRangeTextInputFormatter(min: widget.min, max: widget.max)
      ],
    );
  }
}

class _NumberTextFieldView extends StatelessWidget {
  const _NumberTextFieldView(
      {required this.padding,
      Key? key,
      required this.minus,
      required this.onLongPressCancel,
      required this.onTap,
      required this.onLongPress,
      required this.controller,
      this.hintText,
      this.helperText,
      required this.showPasteIcon,
      this.error,
      this.label,
      this.focusNode,
      required this.allowSign,
      this.inputFormatters,
      required this.disableWriting,
      required this.add,
      this.validator,
      required this.onSubmitField,
      required this.onPaste})
      : super(key: key);
  final EdgeInsetsGeometry padding;
  final bool minus;
  final DynamicVoid onLongPressCancel;
  final BoolVoid onTap;
  final BoolVoid onLongPress;
  final TextEditingController controller;
  final String? hintText;
  final String? helperText;
  final bool showPasteIcon;
  final String? error;
  final String? label;
  final FocusNode? focusNode;
  final bool allowSign;
  final List<TextInputFormatter>? inputFormatters;
  final bool disableWriting;
  final bool add;
  final NullStringString? validator;
  final StringVoid onSubmitField;
  final StringVoid onPaste;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          ConstraintsBoxView(
            maxWidth: 350,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    WidgetConstant.height8,
                    AnimatedContainer(
                      duration: APPConst.animationDuraion,
                      decoration: BoxDecoration(
                          color: minus
                              ? context.theme.highlightColor
                              : Colors.transparent,
                          shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () => onTap(false),
                        onLongPress: () => onLongPress(false),
                        onLongPressEnd: (e) => onLongPressCancel(),
                        child: IconButton(
                            onPressed: () {
                              onTap(false);
                            },
                            icon: const Icon(
                                Icons.indeterminate_check_box_rounded)),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    autovalidateMode: AutovalidateMode.always,
                    focusNode: focusNode,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: allowSign),
                    controller: controller,
                    validator: validator,
                    onFieldSubmitted: onSubmitField,
                    minLines: null,
                    maxLines: null,
                    inputFormatters: inputFormatters,
                    //  [
                    //   FilteringTextInputFormatter.digitsOnly,
                    //   RangeTextInputFormatter(min: widget.min, max: widget.max)
                    // ],
                    readOnly: disableWriting,
                    decoration: InputDecoration(
                        filled: true,
                        hintText: hintText,
                        helperText: helperText,
                        suffixIcon: showPasteIcon
                            ? PasteTextIcon(
                                onPaste: onPaste, isSensitive: false)
                            : null,
                        errorText: error,
                        labelText: label,
                        border: OutlineInputBorder(
                            borderRadius: WidgetConstant.border8,
                            borderSide: BorderSide.none)),
                  ),
                ),
                Column(
                  children: [
                    WidgetConstant.height8,
                    AnimatedContainer(
                      duration: APPConst.animationDuraion,
                      decoration: BoxDecoration(
                          color: add
                              ? context.theme.highlightColor
                              : Colors.transparent,
                          shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () => onTap(true),
                        onLongPress: () => onLongPress(true),
                        onLongPressEnd: (e) => onLongPressCancel(),
                        child: IconButton(
                          icon: const Icon(Icons.add_box),
                          onPressed: () {
                            onTap(true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
