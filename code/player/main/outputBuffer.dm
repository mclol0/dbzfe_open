outputBuffer
	var
		mob/mobRef = NULL;
		buffer = ""

	New(mob/m){
		..()
		mobRef = m;
		mobRef.output = src;
		readBuffer();
	}

	Del(){
		..()
	}

	proc
		uninit(){
			mobRef.output=NULL;
			mobRef=NULL;
			buffer=NULL;
			clean();
		}

		flush(){
			buffer = "";
		}

		add(buff){
			buffer += buff;
		}

		readBuffer(){
			set waitfor = FALSE;
			set background = TRUE;

			var/outBuf = NULL;

			while(src && mobRef && mobRef.client){

				/* Bust a error message */
				if(mobRef.client.state == STATE_PLAYING && mobRef.client.bust_error) {
					add("{cType '{x{Ccommands{x{c'{x {WOR{x{c '{x{Cskills{x{c' for a full list of available commands/skills.{x\n");
					mobRef.client.bust_error = FALSE;
				}

				/* Bust a prompt */
				if(mobRef.client.state == STATE_PLAYING && mobRef.client.bust_prompt) {
					if(mobRef.frozen){
						add("{W<{x{CFROZEN{x{W>{x");
					}else{
						add("[mobRef.client.client_prompt()][mobRef.lastPLGain != 0 ? " [mPlus(mobRef:retLastPL())] PL" : ""][mobRef.lastLCGain != 0 ? " {G[mobRef:retLastLC()]{x LC" : ""]");
					}

					mobRef.client.bust_prompt = FALSE;
				}

				/* Send and then flush our output buffer */
				if(length(buffer) > 0){

					outBuf = rColor(buffer,mobRef.cColor,getColor(mobRef.client));

					mobRef << {"\n[outBuf]"};

					if(mobRef.snooper && mobRef.snooper:client) { mobRef.snooper << {"\n[outBuf]"}; }

					outBuf = NULL; // Flush our readbuffers outputBuffer.

					flush() // Flush our output buffer
				}

				sleep(world.tick_lag)
			}

			clean();
		}
