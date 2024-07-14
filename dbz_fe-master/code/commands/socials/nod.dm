Command/Public/Socials
    nod
        name = "nod"
        internal_name = "nod"
        format = "~nod; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{cnod{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou nod at [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] nods at [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] nods at you.", target);
                        send("{c[user] nods at [target].", witnesses);
                    }
                }
                else {
                    send("{cYou nod.", user);
                    send("{c[user] nods.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }
        }
