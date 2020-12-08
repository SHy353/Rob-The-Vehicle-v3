class CMatchLogger
{
    Round = {};

    StartTime = 0;

    LogName = null;

    blue_temp = {};
    red_temp = {};

    function BeginRecord( baseid, basename, defender )
    {
        this.LogName = "MatchLog-" + ::date( ::time() ).year + date( ::time() ).month + ::date( ::time() ).day + "-" + format( "%02d", ::date( ::time() ).hour ) + format( "%02d", ::date( ::time() ).min );
        this.Round = {};

        this.Round.rawset( "base_id", baseid );
        this.Round.rawset( "base_name", basename );
        this.Round.rawset( "defender", defender );
        this.Round.rawset( "round_time", 0 );
        this.Round.rawset( "round_date", ::time() );
        this.Round.rawset( "win_type", 0 );
        this.Round.rawset( "blue_name", Handler.Handlers.Gameplay.BlueTeamName );
        this.Round.rawset( "red_name", Handler.Handlers.Gameplay.RedTeamName );
      
        this.Round.rawset( "player_blue", {} );
        this.Round.rawset( "player_red", {} );
        this.Round.rawset( "kill_log", [] );

        blue_temp = {};
        red_temp = {};

        this.StartTime = ::time();
    }

    function AddKills( killer, killerteam, plr, plrteam, weapon, distance = 0 )
    {
        local defineTeamKiller = ( killerteam == 1 ) ? red_temp : blue_temp;
        local defineTeamVictim = ( plrteam == 1 ) ? red_temp : blue_temp;

        local defineTeamKillerOpp = ( killerteam == 2 ) ? red_temp : blue_temp;
        local defineTeamVictimOpp = ( plrteam == 2 ) ? red_temp : blue_temp;

        if( !defineTeamVictim.rawin( plr ) )
        {
            defineTeamVictim.rawset( plr, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( defineTeamVictimOpp.rawin( plr ) )
        {
            defineTeamVictim[ plr ].kills = defineTeamVictimOpp[ plr ].kills;
            defineTeamVictim[ plr ].deaths = defineTeamVictimOpp[ plr ].deaths;  
            defineTeamVictim[ plr ].assist = defineTeamVictimOpp[ plr ].assist;  
            defineTeamVictim[ plr ].score = defineTeamVictimOpp[ plr ].score;  

           defineTeamVictimOpp.rawdelete( plr );
        }

        if( !defineTeamKiller.rawin( killer ) )
        {
            defineTeamKiller.rawset( killer, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( defineTeamKillerOpp.rawin( killer ) )
        {
            defineTeamKiller[ killer ].kills = defineTeamKillerOpp[ killer ].kills;
            defineTeamKiller[ killer ].deaths = defineTeamKillerOpp[ killer ].deaths;  
            defineTeamKiller[ killer ].assist = defineTeamKillerOpp[ killer ].assist;  
            defineTeamKiller[ killer ].score = defineTeamKillerOpp[ killer ].score;  

           defineTeamKillerOpp.rawdelete( killer );
        }

        defineTeamKiller[ killer ].kills ++;
        defineTeamVictim[ plr ].deaths ++;

        defineTeamKiller[ killer ].score += 2;

        this.Round.kill_log.append( killer + " killed " + plr + " with " + weapon );
    }

    function AddKillsAssist( killer, killerteam, killer2, killer2team, plr, plrteam, weapon, distance = 0 )
    {
        local defineTeamKiller = ( killerteam == 1 ) ? "player_red" : "player_blue";
        local defineTeamVictim = ( plrteam == 1 ) ? "player_red" : "player_blue";
        local defineTeamKiller2 = ( killer2team == 1 ) ? "player_red" : "player_blue";

        local defineTeamKillerOpp = ( killerteam == 2 ) ? "player_red" : "player_blue";
        local defineTeamVictimOpp = ( plrteam == 2 ) ? "player_red" : "player_blue";
        local defineTeamKiller2Opp = ( killer2team == 2 ) ? "player_red" : "player_blue";

        if( !this.Round[ defineTeamVictim ].rawin( plr ) )
        {
            this.Round[ defineTeamVictim ].rawset( plr, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( this.Round[ defineTeamVictimOpp ].rawin( plr ) )
        {
            this.Round[ defineTeamVictim ][ plr ].kills = this.Round[ defineTeamVictimOpp ][ plr ].kills;
            this.Round[ defineTeamVictim ][ plr ].deaths = this.Round[ defineTeamVictimOpp ][ plr ].deaths;  
            this.Round[ defineTeamVictim ][ plr ].assist = this.Round[ defineTeamVictimOpp ][ plr ].assist;  
            this.Round[ defineTeamVictim ][ plr ].score = this.Round[ defineTeamVictimOpp ][ plr ].score;  

           this.Round[ defineTeamVictimOpp ].rawdelete( plr );
        }

        if( !this.Round[ defineTeamVictim ].rawin( killer ) )
        {
            this.Round[ defineTeamKiller ].rawset( killer, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( this.Round[ defineTeamKillerOpp ].rawin( killer ) )
        {
            this.Round[ defineTeamKiller ][ killer ].kills = this.Round[ defineTeamKillerOpp ][ killer ].kills;
            this.Round[ defineTeamKiller ][ killer ].deaths = this.Round[ defineTeamKillerOpp ][ killer ].deaths;  
            this.Round[ defineTeamKiller ][ killer ].assist = this.Round[ defineTeamKillerOpp ][ killer ].assist;  
            this.Round[ defineTeamKiller ][ killer ].score = this.Round[ defineTeamKillerOpp ][ killer ].score;  

           this.Round[ defineTeamKillerOpp ].rawdelete( killer );
        }

        if( !this.Round[ defineTeamKiller2 ].rawin( killer2 ) )
        {
            this.Round[ defineTeamKiller2 ].rawset( killer2, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( this.Round[ defineTeamKiller2Opp ].rawin( killer2 ) )
        {
            this.Round[ defineTeamKiller2 ][ killer2 ].kills = this.Round[ defineTeamKiller2Opp ][ killer2 ].kills;
            this.Round[ defineTeamKiller2 ][ killer2 ].deaths = this.Round[ defineTeamKiller2Opp ][ killer2 ].deaths;  
            this.Round[ defineTeamKiller2 ][ killer2 ].assist = this.Round[ defineTeamKiller2Opp ][ killer2 ].assist;  
            this.Round[ defineTeamKiller2 ][ killer2 ].score = this.Round[ defineTeamKiller2Opp ][ killer2 ].score;  

           this.Round[ defineTeamKiller2Opp ].rawdelete( killer2 );
        }

        this.Round[ defineTeamKiller ][ killer ].kills ++;
        this.Round[ defineTeamVictim ][ plr ].deaths ++;
        this.Round[ defineTeamKiller2 ][ killer2 ].assist ++;

        this.Round[ defineTeamKiller ][ killer ].score += 2;
        this.Round[ defineTeamKiller2 ][ killer2 ].score ++;

        this.Round.kill_log.append( killer + " + " + killer2 + " killed " + plr + " with " + weapon );
    }

    function AddDeath( plr, plrteam, weapon )
    {
        local defineTeamVictim = ( plrteam == 1 ) ? red_temp : blue_temp;

        local defineTeamVictimOpp = ( plrteam == 2 ) ? red_temp : blue_temp;

        if( !defineTeamVictim.rawin( plr ) )
        {
            defineTeamVictim.rawset( plr, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( defineTeamVictimOpp.rawin( plr ) )
        {
            defineTeamVictim[ plr ].kills = defineTeamVictimOpp[ plr ].kills;
            defineTeamVictim[ plr ].deaths = defineTeamVictimOpp[ plr ].deaths;  
            defineTeamVictim[ plr ].assist = defineTeamVictimOpp[ plr ].assist;  
            defineTeamVictim[ plr ].score = defineTeamVictimOpp[ plr ].score;  

           defineTeamVictimOpp.rawdelete( plr );
        }

        defineTeamVictim[ plr ].deaths ++;
        defineTeamVictim[ plr ].score --;

        this.Round.kill_log.append( plr + " has dead." );
    }

    function AddScore( plr, plrteam, score )
    {
        local defineTeamVictim = ( plrteam == 1 ) ? red_temp : blue_temp;

        local defineTeamVictimOpp = ( plrteam == 2 ) ? red_temp : blue_temp;

        if( !defineTeamVictim.rawin( plr ) )
        {
            defineTeamVictim.rawset( plr, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( defineTeamVictimOpp.rawin( plr ) )
        {
            defineTeamVictim[ plr ].kills = defineTeamVictimOpp[ plr ].kills;
            defineTeamVictim[ plr ].deaths = defineTeamVictimOpp[ plr ].deaths;  
            defineTeamVictim[ plr ].assist = defineTeamVictimOpp[ plr ].assist;  
            defineTeamVictim[ plr ].score = defineTeamVictimOpp[ plr ].score;  

           defineTeamVictimOpp.rawdelete( plr );
        }

        defineTeamVictim[ plr ].score += score;
    }

    function DecScore( plr, plrteam, score )
    {
        local defineTeamVictim = ( plrteam == 1 ) ? red_temp : blue_temp;

        local defineTeamVictimOpp = ( plrteam == 2 ) ? red_temp : blue_temp;

        if( !defineTeamVictim.rawin( plr ) )
        {
            defineTeamVictim.rawset( plr, 
            {
                kills = 0,
                deaths = 0,
                assist = 0,
                score = 0,
            })
        }

        if( defineTeamVictimOpp.rawin( plr ) )
        {
            defineTeamVictim[ plr ].kills = defineTeamVictimOpp[ plr ].kills;
            defineTeamVictim[ plr ].deaths = defineTeamVictimOpp[ plr ].deaths;  
            defineTeamVictim[ plr ].assist = defineTeamVictimOpp[ plr ].assist;  
            defineTeamVictim[ plr ].score = defineTeamVictimOpp[ plr ].score;  

           defineTeamVictimOpp.rawdelete( plr );
        }

        defineTeamVictim[ plr ].score -= score;
    }

    function WritelogToKill( txt )
    {
        this.Round.kill_log.append( txt );
    }

    function EndRound( wintype )
    {
        try 
        {
            this.Round.round_time = ( ::time() - this.StartTime );
            this.Round.win_type = wintype;

            this.Round[ "player_red" ] = shorting( red_temp );
            this.Round[ "player_blue" ] = shorting( blue_temp );

            if( Handler.Handlers.Script.MatchLogging ) Handler.Handlers.Script.Database.InsertF( "INSERT INTO rtv3_rstats ( Name, Json ) VALUES ( '%s', '%s' )", this.LogName, ::json_encode( this.Round ) );

            return "https://rtv.pl-community.com/panel/matchinfo.php?match=" + this.LogName;
        }
        catch( e ) return "";
    }

    function WriteToFile( filename, text )
    {
        local fhnd = file(filename, "a+");
        foreach(char in text) fhnd.writen(char, 'c'); 
        fhnd.writen('\n', 'c');
        fhnd.close();
        fhnd=null;
    }

	function shorting( team )
	{
		local getMembers = {};
		local t, ta , taa, tta, tat, j , k = 0, i = 0, getStr = null;

		getMembers.rawset( i++, 
		{
			Name	= 0,
			Score   = -5000,
            Kills   = 0,
            Deaths  = 0,
		});

	    foreach( index, value in team )
		{
			getMembers.rawset( i, 
			{
				Name	= index,
				Score   = value.score,
                Kills   = value.kills,
                Deaths  = value.deaths,
			});

			k++;
			i++;		
        }
								
		for( j = 0; j < getMembers.len(); j++ )
		{
			for( local i = 0 ; i<getMembers.len()-1-j; i++ )
			{
				if( ( getMembers.rawin( i ) ) && ( getMembers.rawin( i + 1 ) ) )
				{
					
					if( getMembers[ i ].Score <= getMembers[ i + 1 ].Score )
					{
						
						t = getMembers[ i + 1 ].Name;
						ta = getMembers[ i + 1 ].Score;
						taa = getMembers[ i + 1 ].Kills;
						tta = getMembers[ i + 1 ].Deaths;

						getMembers[ i + 1 ].Name <- getMembers[ i ].Name;
						getMembers[ i + 1 ].Score <- getMembers[ i ].Score;
						getMembers[ i + 1 ].Kills <- getMembers[ i ].Kills;
						getMembers[ i + 1 ].Deaths <- getMembers[ i ].Deaths;

						getMembers[ i ].Name <- t;
						getMembers[ i ].Score <- ta;
                        getMembers[ i ].Kills <- taa;
                        getMembers[ i ].Deaths <- tta;
					}
				}
			}
		}

        local gettable = {};
		for( local i = 0, j = 1; i < k ; i++, j++ )
		{
			//this.BlueTeamScore.append( getMembers[ i ].Name + "~" + getMembers[ i ].Kills + "~" + getMembers[ i ].Assist + "~" + getMembers[ i ].Deaths + "~" + getMembers[ i ].Score );
			

            gettable.rawset( getMembers[ i ].Name,
            {
                kills = getMembers[ i ].Kills,
                deaths = getMembers[ i ].Deaths,
                score = getMembers[ i ].Score,
            })
            
            
		}

        return gettable;

	}

    function IsParticipate( id )
    {
        if( red_temp.rawin( id ) ) return true;
        if( blue_temp.rawin( id ) ) return true;
    }

    function GetRoundData( id )
    {
        if( red_temp.rawin( id ) ) return red_temp[ id ];
        if( blue_temp.rawin( id ) ) return blue_temp[ id ];
    }

}