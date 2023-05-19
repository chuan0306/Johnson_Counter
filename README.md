# Johnson_Counter
6-bit Johnson Counter circuit with DFF.
____________________________________
| Name | I/O | Width | Description |
|------|-----|-------|-------------|
| clk | I | 1 | System clock signal. The system is synchronized with the **positice edge** of the clock
| rst | I | 1 | Activate-high **asynchronous** reset signal |
| q | O | 6 | A Vector with element of Q6~Q1 from DFF, with MSB from Q6 and LSB Q1 |
- DFF 1 is first shift register
- DFF 6 is last shift register

