Command/Public/Socials
    disagree
        name = "disagree"
        internal_name = "disagree"
        format = "~disagree; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{cdisagree{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou disagree with [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] disagrees with [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] disagrees with you.", target);
                        send("{c[user] disagrees with [target].", witnesses);
                    }
                }
                else {
                    send("{cYou disagrees wholeheartedly.", user);
                    send("{c[user] disagrees wholeheartedly.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
