
# Given an app context, writes to stdout the app name and the app version
# seperated by a '%'.
#
# see.http://erlang.org/doc/apps/kernel/application.html#which_applications-0
# it assumes the app name is the first listed, which appears to be true.

:application.which_applications
|> List.first
|> Tuple.to_list
|> Enum.slice(1, 2)
|> Enum.join("|")
|> IO.puts
