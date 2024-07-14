Command/Public/Socials
    poke
        name = "poke"
        internal_name = "poke"
        format = "~poke; !searc(mob@mobiles);";
        priority = 1
        iCommand = FALSE;
        syntax = "{cpoke{x {c<{x{Cmobile{c>{x";

        command(mob/user, mob/target) {
            var/list/witnesses = _ohearers(0,user);
            witnesses-= target;
            witnesses -= user;
            if(!target || (target.loc == user.loc)) {
                if(target) {
                    send("{cYou poke [target] on the shoulder.", user);
                    
                    if(target == user || lowertext(target) == "self") {
                        send("{c[user] pokes [user.determineSex(2)]self on the shoulder.", _ohearers(0,user));
                    } else {
                        send("{c[user] pokes you on the shoulder.", target);
                        send("{c[user] pokes [target] on the shoulder.", witnesses);
                    }
                }
                else {
                    send("{cYou pokes the air with a child-like wonder.", user);
                    send("{c[user] pokes the air with a child-like wonder.", _ohearers(0,user));
                }
            } else {
                send("{DThey do not appear to be in the same room as you.",user)
            }

        }
