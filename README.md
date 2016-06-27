StatoshiAutoNode
================


Notwhere near ready, but putting in actual visualization crashed one butt instance and got me kicked off a VPS provider, caveat emptor (does that apply if you didn't buy it?)


Instructions
===========

Oh come on. sudo ./ the file. Tested on Ubuntu 16.4 and 14.4, needs a bit more work on Debian 8.5. 

To run, get an el cheapo box (or a decent butt instance if you're brave), SSD preferred, KVM performs well but bigger footprint, ultimately 85-95GB will be taken up after all the dependencies get installed. A full install these days would be 150GB or so, but it's probably still a good idea to output the data to somewhere else for safekeeping either from StatsD or Graphite regardless of how big of an SSD you got on the cheap.

So this is a working node but that's pretty much it. cp -rm $yourdirectory/bitcoin.conf /$user/.bitcoin/bitcoin.conf after the reboot. Personally I used nixstats to keep track but I also have a ton of servers around. It ate up a whole 90GB SSD and crashed in about 4 hours, but at 150GB it turns out the actual chain isn't that big, just you add in overhead an shit that you might not need yet. 

Feel free to swap out the IPs, they're going to my carbon/telegraf/graphite instance but one thing at a time. InfluxDB is very easy to set up so if you find room you can do that. 

My biggest regret was not integrating https://github.com/bartromgens/bitcoinnodestats but I either ran out of space or was told to leave. I managed to sneak https://github.com/NIXStats/nixstats-agent in ahead of time.

Short term: IPTables,also actual visualization at some point, and set up InfluxDB (already done actually).


Long term
==========

I'm curious if you take the miners out of the equation wwhat do the people really want. Also, potentail dockerization? So hot right now, that docker, but I see no additional benefit and think you need VMDK, VHD, or KVM because just containers aren't gonna cut it unless you really tune down the performance and then what's the point? We'll see. Should be able to put data from Classic, XT, Unlimited (tempted to just roll out a shit ton of XTs for shits and giggles). 

Licensing:
==========


Oh and this is licensed under "haha you guys think all those licenses matter, the judges making the calls can barely work their phones" license. I have the rights to my original creation that is ultimate a derivative, but sicne I am not registering it, I can't enforce any part of it anyway, and this would be the most browserwrap of browserwrap of contracts and the law haven't entirely caught up. Since making it public domain is more effort I'll just leave it at "don't violate the Lanham Act 43(a)" License and be done with it, Google Scholar is your friend. In other words this is and pretty much anything I write will be A GIFT NOT SUPPORTED BY CONSIDERATION (see nickname) THAT YOU MAY FREELY USE WHILE I AM LEGALLY UNABLE TO ENFORCE WHAT IS PROBABLY NOT INFRINGEMENT. I'll listen to whatever the notorious RBG says (exceptions made for Easterbrook, Posner, and Kozinski out of court). That said, outside of the guy I forked this off of @jlopp gets the creds for inspiring my love for data, visualization, and laziness while knowing that there are people who are more interested and lazier than me.

Oh, and just because I ommited to take out the ability to to mak this a wallet-enabled node doesn't mean it's a good idea at all, don't do it. 
 
 FEel free to email me at jim@vellicle.com and if you're wondering what vellicle means it means somehow someone got the twitter handle of a really ancient English word before I did
