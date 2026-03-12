import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryDayPicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DeliveryDayPicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  List<DateTime> _generateDays() {
    return List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  String _getFormattedLabel(DateTime date) {
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    if (DateUtils.isSameDay(date, now)) {
      return "Today, ${DateFormat('MMMM d').format(date)}";
    } else if (DateUtils.isSameDay(date, tomorrow)) {
      return "Tomorrow, ${DateFormat('MMMM d').format(date)}";
    }

    return DateFormat('EEEE, MMMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final days = _generateDays();

    final currentValue = days.firstWhere(
      (d) => DateUtils.isSameDay(d, selectedDate),
      orElse: () => days.first,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DateTime>(
            value: currentValue,
            isExpanded: true,
            icon: Icon(
              Icons.arrow_drop_down,
              color: colorScheme.onSurfaceVariant,
            ),
            borderRadius: BorderRadius.circular(16),
            dropdownColor: colorScheme.surfaceContainerHighest,

            selectedItemBuilder: (BuildContext context) {
              return days.map<Widget>((DateTime date) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _getFormattedLabel(date),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList();
            },
            onChanged: (DateTime? newValue) {
              if (newValue != null) onDateSelected(newValue);
            },

            items: days.map((DateTime date) {
              final isSelected = DateUtils.isSameDay(date, selectedDate);

              return DropdownMenuItem<DateTime>(
                value: date,
                child: _HoverableDropdownItem(
                  label: _getFormattedLabel(date),
                  isSelected: isSelected,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _HoverableDropdownItem extends StatefulWidget {
  final String label;
  final bool isSelected;

  const _HoverableDropdownItem({required this.label, required this.isSelected});

  @override
  State<_HoverableDropdownItem> createState() => _HoverableDropdownItemState();
}

class _HoverableDropdownItemState extends State<_HoverableDropdownItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isActive = widget.isSelected || _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Opacity(
              opacity: widget.isSelected ? 1.0 : 0.0,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: TextStyle(
                color: isActive ? colorScheme.onPrimary : colorScheme.onSurface,
                fontWeight: widget.isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
