with Ada.Task_Identification;
with Ada.Text_IO;

procedure Sequential
is
   use Ada.Task_Identification;
   use Ada.Text_IO;
   
   Id   : constant String := Image (Current_Task);
   Jobs : Positive := 20;
begin
   for Job in reverse 1 .. Jobs loop
      for K in 1 .. 1_000_000_000 loop
	 null; --  This is really hard!
      end loop;
      
      Put_Line ("Job" & Positive'Image (Job) & " done by " & Id);
   end loop;
end Sequential;
