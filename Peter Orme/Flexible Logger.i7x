Version 3/171019 of Flexible Logger by Peter Orme begins here.

"A logging tool for I7 that lets you log to transcript and/or file (for Glulx)"

Include Developer Framework by Peter Orme.
Use Authorial modesty.

Section 1 - Logging for all

Console log level is a severity that varies. Console log level is usually every level.

to console log (msg - an indexed text) at (level - a severity) :
	unless level is less than console log level:
		say "([level] turn [turn count]) [msg][line break]"

Section 2 - Shortcuts 

to debug (msg - indexed text):
	log msg at debug level;

to info (msg - indexed text):
	log msg at info level;
	
to warn (msg - indexed text):
	log msg at warning level;

to error (msg - indexed text):
	log msg at error level;

Section 3 - File Logging (for Glulx only)

The logging file is an external file that varies. 

The File of Logging is called "informlog". 

The logging file is the File of logging.

File log level is a severity that varies. File log level is usually warning level.

To file log (msg - indexed text) at (level - a severity) :
	unless level is less than file log level:
		append "([level] turn [turn count]) [msg][line break]" to the logging file;

To log (msg - indexed text) at (chosen level - a severity):
	file log msg at chosen level;
	console log msg at chosen level;

Section 4 - Fallback Logging (for Z-machine only) 
[With Z-machine, all the logging is just console logging]

To log (msg - indexed text) at (chosen level - a severity):
	console log msg at chosen level.
	
Section 5 - Getting information about the logging at runtime - not for release

dev log inspecting is an action out of world applying to nothing.

understand "dev log info" as dev log inspecting;

carry out dev log inspecting (this is the standard dev log inspecting rule):
	say "Console log level: [console log level]." (A);
	
Section 6 - Setting the console log level at runtime - not for release 

dev log level setting is an action applying to one severity.

understand "dev log set [any severity]" as dev log level setting.

carry out dev log level setting (this is the standard dev log level setting rule):
	say "Changing the console log level to [the severity understood]." (A);
	now the console log level is the severity understood.
	
Section 7 - Printing the help text - not for release 

dev log helping is an action out of world applying to nothing.

understand "dev log help" as dev log helping.

carry out dev log helping (this is the standard dev log helping rule):
	say "[bold type]dev log help[roman type] - prints this help text.";
	say "[bold type]dev log info[roman type] - prints some information about the logger.";
	say "[bold type]dev log set [italic type]severity[roman type] - sets the console log level to a given severity.";
	say "The lower the severity, the more logging you will get (assuming, of course, that the story or extensions you are using performs any logging in the first place). The severities are as follows: [the list of severities].";

Flexible Logger ends here.

---- DOCUMENTATION ----

This extension lets you log messages from any point in your Inform7 code by just doing "debug 'Whatever message';". 

The message will then appear in the transcript as 
"(debug level turn 14) Whatever message"

Chapter: log levels 

For some more control, you can use predefined log levels. These use the severity kind defined in the extension Developer Framework. You can use those to log something at a specified severity:

	log "this is logged as information." at info level.

You can do this:

	debug "This is a debug message.";

That's really just a shortcut for doing this:

	log message "This is a debug message." at debug level.

There are such shortcuts for all four log levels, so you can just do this:

	error "This is an error message";

You can control the minimum level at which log messages are shown using two settings:

	now console log level is warning level.

That line means that only warnings and errors are displayed, while debug and info messages are silently ignored. For this purpose there are actually two extra log levels, one at each end, log.off and log.all.

	now console log control is off level.

These work as expected: setting the log level to off level turns all logging off, every level turns all logging on. 

There's a reason the log level is called "console log level": there are two logs, one to console, and one to file. This only works for Glulx, if you are using z-machine you only get console logging. 

Chapter: Logging to file

The filename used for logging is by default informlog.glkdata, in the folder where glulx decides to put it, probably where the main file is. You can change it like this:

	The File of Custom Logging is "myCustomLog";

	when play begins:
		now the logging file is the File of Custom Logging. 

Of course you can just switch file logging off:

	now file log level is off level;

A corresponding file (informlog.glkdata) will be saved to file. 

Chapter: Runtime commands

In version 3 of this extension, we also added some commands that you can while testing the game. The are all marked as "not for release".

The player command "dev log info" will show information about the logging. 

The player command "dev log set debug level" (etc) will change the console log level to the given severity. 

Note that you need to type in "level" at  the end. The severities are defined in the Developer Framework extension, and they are "every level", "debug level", "info level", "warning level", "error level", and "off level".  

There is also a "dev log help" command which will print some instructions about how this works. 

Chapter: Version History

Version 3: Adding the runtime commands "dev log info" and "dev log set [any severity]".

Example: * Hello log - A minimal example. Just include and "debug", "warn" etc.

	*: "Hello logger"

	Include Flexible Logger by Peter Orme.

	There is a room. 

	When play begins: 
		debug "Hello log!";
		warn "This is a warning.";

Example: ** Controlled Logging - an example with some more features.

	*: "Controlled Logging"

	Include Flexible Logger by Peter Orme.

	There is a room. 

	when play begins:
		now file log level is every level;
		info "Play begins";

