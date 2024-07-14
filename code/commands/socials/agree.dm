Command/Public/Socials
    agree
        name = "agree"
        internal_name = "agree"
        format = "~agree; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{cagree{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou agree with [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] agrees with [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] agrees with you.", target);
                        send("{c[user] agrees with [target].", witnesses);
                    }
                }
                else {
                    send("{cYou agrees wholeheartedly.", user);
                    send("{c[user] agrees wholeheartedly.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
