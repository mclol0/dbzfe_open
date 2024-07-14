Command/Wiz
	setform
		name = "setform";
		immCommand = 1
		immReq = 3
		format = "~setform; !searc(mob@mobiles)|~searc(mob@mobiles); !any";
		syntax = list("mobile", "form")

		command(mob/user, mob/m, formName) {
			if(m && formName){
				var/fForm/form = gForm.get(formName);
				if (form && lowertext(form.name) == lowertext(formName)) {
					m.form = form.name
					m.CheckForm()
					return
				}

				send("Incorrect form", user)
			}
			else{
				syntax(user,getSyntax());
			}
		}