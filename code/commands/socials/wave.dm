Command/Public/Socials
    wave
        name = "wave"
        internal_name = "wave"
        format = "~wave; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{cwave{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou wave at [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] wave at [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] waves at you.", target);
                        send("{c[user] waves at [target].", witnesses);
                    }
                }
                else {
                    send("{cYou wave.", user);
                    send("{c[user] waves.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
