with Ada.Task_Identification;
With Ada.Text_IO;

procedure Concurrent
is
   use Ada.Task_Identification;
   use Ada.Text_IO;
   
   protected Jobs is
      procedure Get 
	(Job : out Natural);
   private
      J : Natural := 20;
   end Jobs;
   
   ------------
   --  Jobs  --
   ------------
   
   protected body Jobs is
      -----------
      --  Get  --
      -----------
      
      procedure Get 
	(Job : out Natural)
      is
      begin
	 Job := J;
	 if J > 0 then
	    J := J - 1;
	 end if;
      end Get;
   end Jobs;
   
   task type Worker;
   --  The Worker gets a job, and does the hard work.
   --  When there are no more jobs, the Worker exits.
   
   --------------
   --  Worker  --
   --------------
   
   task body Worker is
      A_Job : Natural;
      Id    : constant String := Image (Current_Task);
   begin
      loop
	 Jobs.Get (A_Job);
	 
	 exit when A_Job < 1; 
	 
	 for K in 1 .. 1_000_000_000 loop
	    null; --  This is really hard!
	 end loop;
	 
	 Put_Line ("Job" & Natural'Image (A_Job) & " done by " & Id);
      end loop;
   end Worker;
   
   Workers : array (1 .. 4) of Worker;
begin
   null; --  We're not using the main environment task for anything.
end Concurrent;
