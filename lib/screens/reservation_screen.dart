import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';
import '../theme.dart';

/// FEATURE 2: Table reservation.
/// A separate complex process from ordering: date/time/guest selection,
/// validation, and a confirmation state held in ReservationState.
class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  DateTime? _date;
  TimeOfDay? _time;
  int _guests = 2;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 18, minute: 30));
    if (picked != null) setState(() => _time = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a table')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Date', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            OutlinedButton(
              onPressed: _pickDate,
              child: Text(_date == null
                  ? 'Select a date'
                  : '${_date!.day}/${_date!.month}/${_date!.year}'),
            ),
            const SizedBox(height: 16),
            const Text('Time', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            OutlinedButton(
              onPressed: _pickTime,
              child: Text(_time == null ? 'Select a time' : _time!.format(context)),
            ),
            const SizedBox(height: 16),
            const Text('Guests', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => setState(() => _guests = _guests > 1 ? _guests - 1 : 1),
                ),
                Text('$_guests', style: const TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => setState(() => _guests++),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: (_date != null && _time != null)
                  ? () {
                      context.read<ReservationState>().setReservation(
                            date: _date!,
                            time: _time!.format(context),
                            guests: _guests,
                          );
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Reservation confirmed'),
                          content: Text(
                              'Table for $_guests on ${_date!.day}/${_date!.month}/${_date!.year} at ${_time!.format(context)}.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              child: const Text('Confirm reservation'),
            ),
          ],
        ),
      ),
    );
  }
}
