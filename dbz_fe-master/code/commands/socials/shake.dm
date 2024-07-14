Command/Public/Socials
    shake
        name = "shake"
        internal_name = "shake"
        format = "~shake; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{cshake{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou shake your head at [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] shakes [user.determineSex(1)] head at [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] shakes [user.determineSex(1)] head at you.", target);
                        send("{c[user] shakes [user.determineSex(1)] head at [target].", witnesses);
                    }
                }
                else {
                    send("{cYou shake your head.", user);
                    send("{c[user] shakes [user.determineSex(1)] head.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
