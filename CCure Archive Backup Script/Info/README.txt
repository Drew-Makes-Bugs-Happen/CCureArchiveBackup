Automatic backup script for Cross & Crown's CCure access control database.

Built by Drew Butler.



Use:
	Script Setup
		1. Set "keepbackups" variable in "VARIABLE DEFINITION" block to the number of days that should be backed up.
		2. Set ALL origin and destination paths for ALL xcopy, echo, dir, and rd commands. Notated by "rem !!!" on above line
	Scheduling Setup
		1. Run "taskschd.msc"
		2. Actions>Create Task
		3. Configure



How it works:
	Script
		1. Script copies the [BACKUPS DIRECTORY] directory to the external Seagate hard drive
		2. Script logs successful backups in Logs>UpdateLog.txt
		3. In case of failiure, script stops and logs errors in Logs>ErrorLog.txt
		4. Script checks how many days of logs exist, and deletes oldest files should the number of backup days exceeds predetermined max.
	Scheduling
		I used Window's built-in Task Scheduler to run DatabaseBackup.bat on an interval of choice.