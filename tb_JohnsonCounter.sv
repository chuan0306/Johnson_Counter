`timescale 1ns/10ps
`define CYCLE      50.0  
`define End_CYCLE  1000000
`define GOLDEN     "golden.data"

`include "JohnsonCounter.v"

module tb_JohnsonCounter;

    // Register
    logic clk = 0;
    logic rst = 0;
    logic [5:0] q;

    // Test Module
    JohnsonCounter jc
    (
        .clk(clk), 
        .rst(rst),
        .q(q)
    );

    // System Clock
    always 
    begin 
        #(`CYCLE / 2) clk = ~clk; 
    end
    // Initialization
    initial 
    begin
        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");
        rst = 1'b1; 
        #(`CYCLE * 2);  
        rst = 1'b0;
    end

    integer fg;
    logic [22:0] cycle=0;
    // Check whether in forever loop
    always @(posedge clk) 
    begin
        cycle = cycle + 1;
        if (cycle > `End_CYCLE) 
        begin
            $display("--------------------------------------------------");
            $display("-- Failed waiting valid signal, Simulation STOP --");
            $display("--------------------------------------------------");
            $fclose(fg);
            $finish;
        end
    end
    // Read Golden data
    initial 
    begin
        fg = $fopen(`GOLDEN,"r");
        if (fg == 0) 
        begin
            $display ("golden handle null");
            $finish;
        end
    end

    integer pass = 0;
    integer fail = 0;
    integer golden = 0;
    string goldenLine;
    integer testNumber = 0;

    logic [5:0] GQ;
    
    always @(negedge clk)
    begin
        if (!rst)
        begin
            if (!$feof(fg))
            begin
                golden = $fgets (goldenLine, fg);
                if (golden != 0)
                begin
                    testNumber = testNumber + 1;
                    golden = $sscanf(goldenLine, "%b", GQ);
                    if (q == GQ) 
                    begin
                        pass = pass + 1;
                    end
                    else
                    begin
                        $display("\n[Test %2d]\n\tOutput = %b\n\tExpect Output = %b",
                                    testNumber, q, GQ);
                        fail = fail + 1;
                    end
                end
            end
            else
            begin
                $fclose(fg);
                if (fail === 0)
                begin
                    $display("\n");
                    $display("\n");
                    $display("        ****************************    _._     _,-'\"\"`-._        ");
                    $display("        **  Congratulations !!    **   (,-.`._,'(       |\\`-/|     ");
                    $display("        ** Implementation1 PASS!! **       `-.-' \\ )-`( , o o)     ");
                    $display("        ****************************             `-    \\`_`\"'-    ");
                    $display("\n");
                end
                else
                begin
                    $display("\n");
                    $display("\n");
                    $display("        ****************************         |\\      _,,,---,,_     ");
                    $display("        **  OOPS!!                **   ZZZzz /,`.-'`'    -.  ;-;;,_  ");
                    $display("        **Implementation1 Failed!!**        |,4-  ) )-,_. ,\\ (  `'-'");
                    $display("        ****************************       '---''(_/--'  `-'\\_)     ");
                    $display("         Totally has %d errors                                       ", fail); 
                    $display("\n");
                end
                result(fail, (pass + fail));
                $finish;
            end
        end
    end

    task result;
        input integer err;
        input integer num;
        integer rf;
        begin
            rf = $fopen("result.txt", "w");
            $fdisplay(rf, "%d,%d", num - err, num);
        end
    endtask
endmodule