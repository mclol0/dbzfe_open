Command/Public/Socials
    smile
        name = "smile"
        internal_name = "smile"
        format = "~smile; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{csmile{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou smile at [target].", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] smile at [user.determineSex(2)]self.", _ohearers(0,user));
                    } else {
                        send("{c[user] smiles at you.", target);
                        send("{c[user] smiles at [target].", witnesses);
                    }
                }
                else {
                    send("{cYou smile wholeheartedly.", user);
                    send("{c[user] smiles wholeheartedly.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
