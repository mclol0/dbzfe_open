Command/Public/Socials
    raise
        name = "raise"
        internal_name = "raise"
        format = "~raise; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{craise{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou raise your hand at [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] raises [user.determineSex(1)] hand at [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] raises [user.determineSex(1)] hand at you.", target);
                        send("{c[user] raises [user.determineSex(1)] hand at [target].", witnesses);
                    }
                }
                else {
                    send("{cYou raise your hand.", user);
                    send("{c[user] raises [user.determineSex(1)] hand.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
