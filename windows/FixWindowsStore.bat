net stop wuauserv

cd %systemroot%\SoftwareDistribution

ren Download Download.old

net start wuauserv