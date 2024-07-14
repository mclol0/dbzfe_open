Command/Public/Socials
    tip
        name = "tip"
        internal_name = "tip"
        format = "~tip; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{ctip{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;

            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou tip your hat at [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] tips [user.determineSex(1)] hat at [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] tips [user.determineSex(1)] hat at you.", target);
                        send("{c[user] tips [user.determineSex(1)] hat at [target].", witnesses);
                    }
                }
                else {
                    send("{cYou tip your hat.", user);
                    send("{c[user] tips [user.determineSex(1)] hat.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user);
            }
        }
