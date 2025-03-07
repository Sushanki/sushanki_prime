module test;

  initial begin : start

    begin : thread
      #35;
      $display("start #35 t %0t", $time);
    end

    fork :start_fork

      begin :thread1
        #10;
        $display("A #10 t %0t", $time);
        fork :fork2
          begin :thread21
            #20 display("Aa #20 t %0t", $time);
          end
          begin :thread22
            #30;
            $display("Ab #30 t %0t", $time);
            #40;
            $display("Ab #40 t %0t", $time);
          end
          begin :thread23
            #5;
            $display("Ac #5 t %0t", $time);
          end
        join
      end

      begin :thread2
        #5;
        $display("Ba #5 t %0t", $time);
        #20;
        $display("Bb #20 t %0t", $time);
      end

      begin :thread3
        fork :fork3
          begin :thread41
            #50;
            $display("Ca #50 t %0t", $time);
          end
          begin :thread42
            fork :fork4
              begin :thread43
                #10;
                $display("Cba #10 t %0t", $time);
              end
              begin :thread44
                #15;
                $display("Cbb #15 t %0t", $time);
              end
            join
          end
        join
      end

      begin :thread4
        #25;
        $display("D #25 t %0t", $time);
      end

      begin :thread5
        fork :fork5
          begin :thread51
            #50;
            $display("Fa #50 t %0t", $time);
          end
          begin :thread52
            #20;
            $display("Fb #20 t %0t", $time);
            #10;
            $display("Fb #10 t %0t", $time);
            fork :fork6
              begin
                #30;
                $display("Fba #30 t %0t", $time);
              end
              begin
                #35;
                $display("Fbb #35 t %0t", $time);
              end
            join
          end
        join
      end

    join

    $display("out the fork t %0t", $time);

  end

endmodule

