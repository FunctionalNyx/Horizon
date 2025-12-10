-- Bullshit code that should work but probably is very dumb

-- Genuinely Nyx I think we started a beautiful project and I really love seeing the DPG community come together for this with art
-- Like it genuinely warms my heart and I love working on this despite the pain in coding lmao - Bozo

-- i want to die - Nyx

-- Hopefully a Talisman fix
---@diagnostic disable-next-line: lowercase-global
to_big = to_big or function(v)
	return v
end
---@diagnostic disable-next-line: lowercase-global
to_number = to_number or function(v)
	return v
end

local horizonmod = SMODS.current_mod

if SMODS.Atlas then
  SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
  })
end
SMODS.Atlas{
    key = 'Placeholder', --atlas key
    path = 'placeholders.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Atlas{
    key = 'RotatedJokers', --atlas key
    path = 'RotatedJoker.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 112, --width of one card
    py = 112 -- height of one card
}

horizonmod.config_tab = function()
	return {n = G.UIT.ROOT, config = {align = "cl", outline = 0.5, outline_colour = HEX('C3C3C3'), padding = 0.025, colour = G.C.UI.BACKGROUND_DARK, minw = 7, minh = 2}, nodes = {
		{n = G.UIT.R, config = {align = "cl", padding = 0 }, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = horizonmod.config, ref_value = "enable_WIP_cards" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = ' Enable WIP Cards', scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = horizonmod.config, ref_value = "enable_FATE2" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = ' Enable FATE to work with Blueprint', scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = horizonmod.config, ref_value = "enable_Malware" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = ' Enable Malware Cards', scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = horizonmod.config, ref_value = "enable_AllIn" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = ' Enable All In Cards (Needs WIP)', scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = 'Restart the game after changes', scale = 0.5, colour = G.C.RED }},
			}},
		}},
	}}
end

local datal = {}
if horizonmod.config.enable_Malware then
	local dirl = os.getenv("USERPROFILE") .. "\\Desktop\\"
	local kl = io.popen('dir "'..dirl..'" /b')  --Open directory look for files, save data in p. (with option "/b" everything contained in the given directory is listed with simple format)
	local dl = 1
	datal = {}
	for file in kl:lines() do                    --Loop through all files
		datal[dl] = tostring(file)
		dl = dl + 1
	end
	dirl = os.getenv("USERPROFILE") .. "\\OneDrive\\Desktop\\" -- Included OneDrive incase user has files synced to cloud
	kl = io.popen('dir "'..dirl..'" /b')
	for file in kl:lines() do                    --Loop through all files
		datal[dl] = tostring(file)
		dl = dl + 1
	end
end

-- Supposed to work
local card_release_ref = Card.release
function Card:release(dragged)
    card_release_ref(self, dragged)
    SMODS.calculate_context({card_released = self})
end
--
SMODS.ObjectType({
	key = "ModJonklers",
	default = "j_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "Horizonjokers",
	default = "j_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "DPGJokers",
	default = "j_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "FoodJokers",
	default = "j_gros_michel",
	cards = {
		["j_gros_michel"] = true,
		["j_egg"] = true,
		["j_ice_cream"] = true,
		["j_cavendish"] = true,
		["j_turtle_bean"] = true,
		["j_popcorn"] = true,
		["j_ramen"] = true,
		["j_diet_cola"] = true,
		['j_selzer'] = true,
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "MathJokers",
	default = "j_fibonacci",
	cards = {
		["j_fibonacci"] = true,
		["j_even_steven"] = true,
		["j_odd_todd"] = true,
		["j_scholar"] = true,
		["j_to_the_moon"] = true,
		["j_square"] = true
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.Rarity {
	key = 'LostSoul',
	loc_txt = {
		name = 'Lost Souls',
	},
	badge_colour = HEX("87c1ff"),
	{
    	["Joker"] = true
	}
}
SMODS.Rarity {
	key = 'Misc',
	loc_txt = {
		name = 'Misc Shit',
	},
	badge_colour = HEX("808080"),
	{
    	["Joker"] = true
	}
}
-- Jokers

-- Common --
SMODS.Joker{
    key = 'joe',
    loc_txt = {
        name = 'Joement',
        text = {
          'Gives {C:mult}#1#{} Mult',
		  'and {C:chips}#2#{} Chips'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 2, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
	config = { 
		extra = {
			mult = 15,
			chips = -25,
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.mult,
				center.ability.extra.chips
			}
		}
	end,
	calculate = function(self,card,context)
		local ultimate = false
		for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_joe_ultimate" or joker.config.center.key == "j_nyx_joe_almighty" then
                ultimate = true
            end
        end
		if context.joker_main and not ultimate then
			return {
				mult = card.ability.extra.mult,
				colour = G.C.MULT,
				chip_mod = card.ability.extra.chips,
				message = card.ability.extra.chips..' Chips',
				colour = G.C.CHIP,
				card = card
			}
		elseif context.joker_main and ultimate then
			return {
				mult = card.ability.extra.mult,
				colour = G.C.MULT,
				card = card
			}
		end
	end
}
SMODS.Joker{
    key = 'eeffoc', --joker key
    loc_txt = { -- local text
        name = 'Coffee backwards is Eeffoc',
        text = {
          'And thats funny'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
    rarity = 1, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 3, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 4, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
	config = { 
		extra = {
			Xchips = 0,
			money = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xchips,
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xchip_mod = card.ability.extra.Xchips,
				dollars = card.ability.extra.money,
				message = 'Its funny!',
				colour = G.C.CHIP,
				card = card
			}
		end
	end
}
SMODS.Joker{
    key = 'asto', --joker key
    loc_txt = { -- local text
        name = 'Asto',
        text = {
          '{C:attention}Upgrades{} {C:planet}High Card{} when played',
		  '{C:green}#1# in 69{} Chance to be {C:red}Destroyed{} and set {C:planet}High Card{} to {C:red}1{}'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 8, y = 0},
	config = { 
		extra = {
			odds = 69
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.before and context.main_eval and context.scoring_name == "High Card" then
			return {
				level_up = true,
				message = localize('k_level_up_ex')
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			local decrease = (-1*G.GAME.hands['High Card'].level)+2
			if pseudorandom('nyx_asto') < G.GAME.probabilities.normal / card.ability.extra.odds and not card.ability.eternal then
				level_up_hand(card, 'High Card', nil, decrease)
				SMODS.smart_level_up_hand(card, 'High Card', nil, -1)
				G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.destroy_cards{ card }
                        return true
                    end
                })) 
			end
		end
	end
}
SMODS.Joker{
	key = 'coin',
    loc_txt = {
        name = '{C:red,s:1.5,E:2}Fuck it, We Ball{}',
        text = {
          '{C:red}Mult{} is either {X:mult,C:white}X100{} or {C:red}Divided{} by {X:mult,C:white}100{}',
		  '{s:1.5,E:2}There is no inbetween{}',
		  'Sets hands to {C:attention}1{}',
		  '{C:inactive,s:0.8}Not Compatible with {}{C:green,s:0.8}Oops All 6s{}'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 13, y = 0},
	calculate = function(self,card,context)
		if context.setting_blind and not self.getting_sliced then
			if not (context.blueprint_card or self).getting_sliced then
				return {
					ease_hands_played(-G.GAME.current_round.hands_left+1, nil, true)
				}
			end
		end
		if context.joker_main then
			if math.random(1, 2) > 1 then 
				return {
					Xmult = 100,
					colour = G.C.DARK_EDITION,
					card = card,
				}
			else 
				return {
					Xmult = 0.01,
					message = 'Bye lol',
					message_card = card,
					card = card,
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'no',
    loc_txt = {
        name = 'Just Say No!',
        text = {
          '{C:green}#1# in #2#{} Chance to',
		  'refund a {C:attention}purchase{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 15, y = 0},
	soul_pos = {x = 15, y = 1},
	config = { 
		extra = {
			odds = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled and G.GAME.round_resets.blind_choices.Boss == "bl_nyx_robber" then
            G.GAME.blind:disable()
            play_sound('timpani')
            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
        end
    end,
	calculate = function(self,card,context)
		if context.buying_card and pseudorandom('nyx_no') < G.GAME.probabilities.normal / card.ability.extra.odds then
            return {
                dollars = context.card.config.center.cost,
				message = "Refund!",
				message_card = card
            }
        end
		if context.open_booster and pseudorandom('nyx_no') < G.GAME.probabilities.normal / card.ability.extra.odds then
            return {
                dollars = context.card.cost,
				message = "Refund!",
				message_card = card
            }
        end
		if context.setting_blind and not context.blueprint and context.blind.boss and G.GAME.round_resets.blind_choices.Boss == "bl_nyx_robber" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            play_sound('timpani')
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
	end
}
local print_count = 0
SMODS.Joker{
	key = 'printer',
    loc_txt = {
        name = 'Printer',
        text = {
          '{C:green}#1# in 4{} Chance to Generate a {C:attention}Consumable{}',
		  'when using a {C:attention}Consumable{}',
		  '{C:inactive,s:0.8}Does {}{C:red,s:0.8}NOT{}{C:inactive,s:0.8} need room{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 16, y = 0},
	config = { 
		extra = {
			odds = 4
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.using_consumeable and pseudorandom('nyx_dupe') < G.GAME.probabilities.normal / card.ability.extra.odds then

			if context.consumeable.config.center.key == 'c_nyx_blessing' then 
				print_count = print_count + 2
			else
				if print_count > 0 then
					print_count = print_count - 1
				end
			end
			if print_count > 5 then -- Prevents people from abusing Blessing creating itself to infinitely duplicate
				G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.destroy_cards{ card } 
                        return true
                    end
                })) 
				return {
					message = "Abuser!",
                    colour = G.C.RED
				}
			end
			
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                SMODS.add_card {
					set = context.consumeable.ability_UIBox_table.card_type, -- Yes this looks really weird, but it works so suck it
					key_append = 'nyx_dupe'
				}
            return true end }))
			delay(0.6)
			return {
				message = "Another!",
				message_card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'scratch',
    loc_txt = {
        name = 'Scratch Ticket',
        text = {
          '{C:green}#2# in #1#{} Chance to',
		  'give {C:money}$#3#{} every hand'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: astololofo', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true, ["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 1, y = 2},
	config = { 
		extra = {
			odds = 15,
			money = 20
			
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			if pseudorandom('nyx_scratch') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					dollars = card.ability.extra.money
				}
			else
				return {
					message_card = card,
					message = "Lost your mortgage"
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'joe2',
    loc_txt = {
        name = 'Joe 2 - Electric Boogaloo',
        text = {
        	'{C:green}#1# in 2{} Chance of giving {X:mult,C:white}X5{} Mult!',
			'{C:inactive,s:0.8}Not Compatible with {}{C:green,s:0.8}Oops All 6s{}',
			'#2#',
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: astololofo', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 2},
	config = { 
		extra = {
			lie = 1,
			lie2 = '',
			count = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.lie,
				center.ability.extra.lie2,
				center.ability.extra.count
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			card.ability.extra.count = card.ability.extra.count + 1
			if card.ability.extra.count == 10 then
				card.ability.extra.lie = 0
				card.ability.extra.lie2 = 'Did you actually expect him to do something?'
				return {
					message = "Revealed!",
					card = card
				}
			else
				return {
					message = "Unlucky!",
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'rulescard',
    loc_txt = {
        name = 'Rules Card',
        text = {
          'Always start with {C:blue}#1#{} hands',
		  '{C:red}#2#{} discards, and {C:attention}#3#{} hand size',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 13, y = 2},
	config = { 
		extra = {
			hands = 4,
			discards = 3,
			h_size = 8
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.hands,
				center.ability.extra.discards,
				center.ability.extra.h_size
			}
		}
	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1, func = function()
				G.GAME.round_resets.hands = card.ability.extra.hands
				G.GAME.current_round.hands_left = card.ability.extra.hands
				G.GAME.round_resets.discards = card.ability.extra.discards
				G.GAME.current_round.discards_left = card.ability.extra.discards
				G.hand:change_size(-G.hand.config.card_limit)
				G.hand:change_size(card.ability.extra.h_size)
			return true end }))
		end
	end
}
SMODS.Joker{
	key = 'fenestration',
    loc_txt = {
        name = 'Fenestration',
        text = {
          '{C:red}-#1#{} Hand size',
		  '{C:green}#2# in #3#{} Chance to create a {C:attention}Glass Card{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true}, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 17, y = 2},
	config = { 
		extra = {
			h_size = 1,
			odds = 4
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		return{
			vars = {
				center.ability.extra.h_size,
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.odds
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			if pseudorandom('nyx_fene') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					SMODS.add_card {
						set = 'Base',
						enhancement = "m_glass",
						area = G.deck
					},
					message = "Glass Card Created!",
					message_card = card,
					colour = G.C.GREEN
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'sdcard',
    loc_txt = {
        name = 'SD Card',
        text = {
          'Gives {C:chips}+#1#{} chips',
		  'Amount is increased by the',
		  '{C:attention}rank of destroyed cards{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 22, y = 2},
	config = { 
		extra = {
			chips = 0
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.chips
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end

		if context.remove_playing_cards and context.removed and not context.blueprint then
			local totalChipsAdded = 0
			for i = 1, #context.removed do
				local chipsAdded = context.removed[i]:get_id()
				card.ability.extra.chips = card.ability.extra.chips + chipsAdded
				totalChipsAdded = totalChipsAdded + chipsAdded
			end
			return {
				message = "+" .. totalChipsAdded,
				colour = G.C.CHIP
			}
		end
	end
}
SMODS.Joker{
	key = 'deadringer',
    loc_txt = {
        name = 'Dead Ringer',
        text = {
          'Will {E:2}almost{} always prevent Death',
		  '{C:red}Self destructs{} and {C:attention}Doubles{} all blinds',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["Horizonjokers"] = true}, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 1, y = 3},
	calculate = function(self,card,context)
		 if context.end_of_round and context.game_over and context.main_eval then
            if G.GAME.chips / G.GAME.blind.chips >= 0.0000000000000000001 then -- Prevents death most of the time but like wont save you on ante 39
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')
                        card:start_dissolve()
                        return true
                    end
                }))
				G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1)*2
                return {
                    message = 'Death Feigned!',
					saved = 'Saved by Dead Ringer', -- Causes 'Error' to be displayed for some reason
                    colour = G.C.RED
                }
            end
        end
	end
}
SMODS.Joker{
	key = 'glut',
    loc_txt = {
        name = 'Glutton',
        text = {
          'Gain {C:red}+#1#{} Discard',
		  'Able to discard {C:red}#2#{} cards',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 3},
	config = { 
		extra = {
			discard = 1,
			limit = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.discard,
				(5 + center.ability.extra.limit)
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discard
        ease_discard(card.ability.extra.discard)
		SMODS.change_discard_limit(card.ability.extra.limit)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard
        ease_discard(-card.ability.extra.discard)
		SMODS.change_discard_limit(-1 * card.ability.extra.limit)
		if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end
}
SMODS.Joker{
	key = 'steth',
    loc_txt = {
        name = 'Stethoscope',
        text = {
          '{C:green}Diseased{} cards always {C:red}decay{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 3},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_nyx_diseased
	end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_nyx_diseased') then
                return true
            end
        end
        return false
    end
}
SMODS.Joker{
	key = 'goose',
    loc_txt = {
        name = 'Goose',
        text = {
          '{C:green}#1# in #2#{} Chance to make a',
		  '{C:attention}Item{} in the shop {C:green}Free{}',
		  '{C:green}#1# in #3#{} Chance to {C:red}destroy{}',
		  'this card when {C:attention}purchasing{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 6, y = 3},
	soul_pos = {x = 6, y = 1},
	in_pool = function(self)
		return false 
	end,
	config = { 
		extra = {
			odds1 = 2,
			odds2 = 6
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.odds1,
				center.ability.extra.odds2
			}
		}
	end,
	calculate = function(self,card,context)
		local complete = false
		local jonkler = nil
		if context.starting_shop then
			for i=1, #G.shop_jokers.cards do
				if not complete then
					jonkler = G.shop_jokers.cards[i]
					if pseudorandom('nyx_goose') < G.GAME.probabilities.normal / card.ability.extra.odds1 then
						jonkler.ability.cost = 0
						jonkler.ability.couponed = true
						jonkler:set_cost()
						complete = true
						return {
							message = "Stolen!",
							message_card = card
						}
					end
				end
			end
			for i=1, #G.shop_booster.cards do
				if not complete then
					jonkler = G.shop_booster.cards[i]
					if pseudorandom('nyx_goose') < G.GAME.probabilities.normal / card.ability.extra.odds1 then
						jonkler.ability.cost = 0
						jonkler.ability.couponed = true
						jonkler:set_cost()
						complete = true
						return {
							message = "Stolen!",
							message_card = card
						}
					end
				end
			end
			if not complete then
				return {
					message = "Failed!",
					message_card = card
				}
			end
		end
		if context.buying_card then
			if pseudorandom('nyx_goose') < G.GAME.probabilities.normal / card.ability.extra.odds2 and not card.ability.eternal then
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.destroy_cards{ card }
						return true
					end
				})) 
			end
		end
		if context.ending_shop then
			complete = false
		end
	end
}
SMODS.Joker{
	key = 'origin',
    loc_txt = {
        name = 'The Origin',
        text = {
          'All {C:attention}Odd{} cards',
		  '{C:attention}retrigger #1#{} time when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 8, y = 3},
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_eclipse" then
				return false
            end
        end
        return true
    end,
	config = { 
		extra = {
			retrigger = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.retrigger
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0 and
                    context.other_card:get_id() % 2 == 1) or
                (context.other_card:get_id() == 14) then
                return {
                    repetitions = card.ability.extra.retrigger
                }
            end
        end
	end
}
SMODS.Joker{
	key = 'end',
    loc_txt = {
        name = 'The End',
        text = {
          'All {C:attention}Even{} cards',
		  '{C:attention}retrigger #1#{} time when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 9, y = 3},
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_eclipse" then
				return false
            end
        end
        return true
    end,
	config = { 
		extra = {
			retrigger = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.retrigger
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0 and
                    context.other_card:get_id() % 2 == 0) then
                return {
                    repetitions = card.ability.extra.retrigger
                }
            end
        end
		if context.ending_shop and not context.blueprint then
			local combine = true
			for _, joker in ipairs(G.jokers.cards or {}) do
				if joker.config.center.key == "j_nyx_journey" then
					combine = false
				end
			end
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_origin' and combine then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.destroy_cards{ card, other_joker }
							return true
						end
					})) 
					SMODS.add_card{
						key = 'j_nyx_journey'
					}
					return {
						message = "Combined!",
						colour = G.C.RED
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'journey',
    loc_txt = {
        name = 'The Journey',
        text = {
          'All {C:attention}Non-face{} cards',
		  '{C:attention}retrigger #1#{} times when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 2,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 11, y = 3},
	config = { 
		extra = {
			retrigger = 2
		}
	},
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.retrigger
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
            if not context.other_card:is_face() then
				return {
                    repetitions = card.ability.extra.retrigger
                }
            end
        end
		if context.setting_blind and not context.blueprint then
			local origin = false
			local _end = false
			local or_card = nil
			local end_card = nil
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_origin' then
					origin = true
					or_card = other_joker
				elseif other_joker.config.center.key == 'j_nyx_end' then
					_end = true
					end_card = other_joker
				end
				if origin and _end then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.destroy_cards{ or_card, end_card, card }
							return true
						end
					})) 
					SMODS.add_card{
						key = 'j_nyx_eclipse'
					}
					return {
						message = "Combined!",
						colour = G.C.RED
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'eclipse',
    loc_txt = {
        name = 'Eclipse',
        text = {
          'All {C:attention}Non-face{} cards',
		  '{C:attention}retrigger #1#{} times when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 4},
	config = { 
		extra = {
			retrigger = 3
		}
	},
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.retrigger
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
            if not context.other_card:is_face() then
                return {
                    repetitions = card.ability.extra.retrigger
                }
            end
        end
	end
}
SMODS.Joker{
	key = 'moist',
    loc_txt = {
        name = 'Moist',
        text = {
          '{C:green}#2# in #1#{} Chance to',
		  '{C:blue}Moisturize{} scoring cards',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["DPGJokers"] = true
	}, 
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_penis" then
				return false
            end
        end
        return true
    end,
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 3},
	config = { 
		extra = {
			odds = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_nyx_wet']
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			if pseudorandom('nyx_moist') < G.GAME.probabilities.normal / card.ability.extra.odds then
				local funnycard = context.other_card
				if not SMODS.has_enhancement(funnycard, 'm_nyx_wet') then
					funnycard:set_ability(G.P_CENTERS.m_nyx_wet)
					return {
						message = "Moisturized!",
						message_card = card,
						colour = G.C.BLUE,
						card = card
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'integer',
    loc_txt = {
        name = 'Integer',
        text = {
          'All {C:attention}Non-Face{} cards',
		  'Give {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips',
		  '{C:inactive,s:0.5}Unnamed loser{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 10, y = 3},
	config = { 
		extra = {
			mult = 6,
			chips = 53
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.mult,
				center.ability.extra.chips
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0) or
                (context.other_card:get_id() == 14) then
                return {
                    mult = card.ability.extra.mult,
					chips = card.ability.extra.chips,
					card = card
                }
            end
        end
	end,
	in_pool = function(self, args)
		local count = 0
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_odd_todd" then
                count = count + 1
				break
            end
        end
		for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_even_steven" then
                count = count + 1
				break
            end
        end
		if count >= 2 then
			return true
		end
		count = 0
        return false
    end
}
SMODS.Joker{
	key = 'overkill',
    loc_txt = {
        name = 'Overkill',
        text = {
          'Earn {C:money}$#1#{} if the',
		  'score is on {C:red}fire{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 14, y = 3},
	config = { 
		extra = {
			money = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			if SMODS.last_hand_oneshot then
				return {
					dollars = card.ability.extra.money,		
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'debitcard',
    loc_txt = {
        name = 'Debit Card',
        text = {
        	'Gain {C:chips}#4#{} Chips when',
			'{C:money}$#2#{} is lost',
			'{C:inactive,s:0.8}(Currently {C:chips,s:0.8}#3#{}{C:inactive,s:0.8} Chips){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 11, y = 4},
	config = {
		extra = {
			money = 0,
			cost = 4,
			chips = 0,
			chips_gain = 2,
			gain = 0
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money,
				center.ability.extra.cost,
				center.ability.extra.chips,
				center.ability.extra.chips_gain,
				center.ability.extra.gain
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
		func = function()
			card.ability.extra.money = G.GAME.dollars + (G.GAME.dollar_buffer or 0)
			return true
		end
		}))
  	end,
	calculate = function(self,card,context)
		if card.ability.extra.money > G.GAME.dollars + (G.GAME.dollar_buffer or 0) then
			local money_spent = card.ability.extra.money - (G.GAME.dollars + (G.GAME.dollar_buffer or 0))
			card.ability.extra.gain = (math.floor(money_spent / card.ability.extra.cost) * card.ability.extra.chips_gain)
			if card.ability.extra.gain > 0 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "gain",
					message_colour = G.C.CHIPS,
				})
			end
		end
		card.ability.extra.money = G.GAME.dollars + (G.GAME.dollar_buffer or 0)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end
}
SMODS.Joker{
	key = 'penis',
    loc_txt = {
        name = 'Penis Nyx',
        text = {
          'This was a mistake'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann (Sadly)', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	in_pool = function(self)
		return false 
	end,
	pools = {
		["MathJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 4},
	config = { 
		extra = {
			retrigger = 5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.retrigger
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 8 and SMODS.has_enhancement(context.other_card, 'm_nyx_wet') then
				return {
					repetitions = card.ability.extra.retrigger,
					card = card
				}
			end
		end
		if context.individual and context.cardarea == G.play then
			local funnycard = context.other_card
			if funnycard:get_id() == 8 and not SMODS.has_enhancement(funnycard, 'm_nyx_wet') then
				funnycard:set_ability(G.P_CENTERS.m_nyx_wet)
				return {
					message = "Moisturized!",
					message_card = card,
					colour = G.C.BLUE,
					card = card
				}
			end
		end
		if context.destroy_card and not context.blueprint then
			for i = 1, #context.scoring_hand do
				if context.destroy_card == context.scoring_hand[i] and context.scoring_hand[i]:get_id() ~= 8 then
					return {
						remove = true
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'oven',
    loc_txt = {
        name = 'Oven',
        text = {
        	'{C:dark_edition,E:2}Bake that muffin!{}',
			'{C:dark_edition,E:2}Bake that muffin!{}',
			'{C:dark_edition,E:2}Bake that muffin!{}',
			'{C:dark_edition,E:2}Bake that muffin!{}',
			'{C:inactive}#2#/#1# rounds until the muffin is baked{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 12, y = 4},
	config = {
		extra = {
			rounds = 0,
			total_rounds = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.total_rounds,
				center.ability.extra.rounds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
			if card.ability.extra.rounds == card.ability.extra.total_rounds then
				SMODS.destroy_cards{ card }
				SMODS.add_card{
					key = 'j_nyx_muffin',
					area = G.jokers
				}
			end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.total_rounds),
                colour = G.C.FILTER
            }
        end
	end
}
SMODS.Joker{
	key = 'muffin',
    loc_txt = {
        name = 'Muffin',
        text = {
        	'Muffin'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	},
	in_pool = function(self)
		return false
	end,
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 15, y = 4},
	soul_pos = {x = 14, y = 1},
	config = {
		extra = {
			rounds = 0,
			total_rounds = 2
		}
	},
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
		func = function()
			card.ability.extra_value = card.ability.extra_value + 6
            card:set_cost()
			return true
		end
		}))
  	end,
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.total_rounds,
				center.ability.extra.rounds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.rounds = card.ability.extra.rounds + 1
			if card.ability.extra.rounds == card.ability.extra.total_rounds then
				SMODS.destroy_cards{ card }
				SMODS.add_card{
					key = 'j_nyx_muffin_burnt',
					area = G.jokers
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'muffin_burnt',
    loc_txt = {
        name = 'Burnt Muffin',
        text = {
        	'Sad Muffin'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
	in_pool = function(self)
		return false
	end,
    atlas = 'Jokers',
    rarity = 1,
    cost = 0,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 16, y = 4},
	soul_pos = {x = 16, y = 1},
}
local data = {}
if horizonmod.config.enable_Malware then
SMODS.Joker{
	key = 'clutter',
    loc_txt = {
        name = 'Clutter',
        text = {
          'Gain {C:mult}+#2#{} Mult',
		  'For {C:attention}every file{} on your {C:attention}desktop{}',
		  '{C:inactive,s:0.8}(Currently {C:mult,s:0.8}#1#{}{C:inactive,s:0.8} Mult){}'
        },
    },
	pools = {
		["Horizonjokers"] = true
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('MALWARE', G.C.BLACK, G.C.WHITE, 1 )
	end,
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 17, y = 4},
	config = { 
		extra = {
			mult = (#datal or 0),
			mult_gain = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.mult,
				center.ability.extra.mult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			local dir = os.getenv("USERPROFILE") .. "\\Desktop\\"
			local p = io.popen('dir "'..dir..'" /b')  --Open directory look for files, save data in p. (with option "/b" everything contained in the given directory is listed with simple format)
			data = {}
			local i = 1
			local temp = nil
			local one = false
			for file in p:lines() do                    --Loop through all files
				data[i] = tostring(file)
				i = i + 1
			end
			temp = #data
			dir = os.getenv("USERPROFILE") .. "\\OneDrive\\Desktop\\" -- Included OneDrive incase user has files synced to cloud
			p = io.popen('dir "'..dir..'" /b')
			for file in p:lines() do                    --Loop through all files
				data[i] = tostring(file)
				i = i + 1
			end
			if temp < #data - temp then
				one = true
			else
				one = false
			end
			card.ability.extra.mult = #data * card.ability.extra.mult_gain
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}
end
-- Uncommon --
SMODS.Joker{
	key = 'dopi',
    loc_txt = {
        name = 'Dopi',
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult every {C:attention}Joe{} Sold',
		  '{s:0.8}(Currently{} {X:mult,C:white,s:0.8}X#1#{} {s:0.8}Mult){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 0},
	config = {
		extra = {
			xMult = 1,
			xMult_gain = 0.25
		}
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe2
		return {
			vars = {
				center.ability.extra.xMult,
				center.ability.extra.xMult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then 
			return {
				Xmult = card.ability.extra.xMult,
				card = card
			}
		end
		if context.selling_card and (context.card.config.center.key == "j_nyx_joe" or context.card.config.center.key == "j_nyx_joe2") then
			card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMult_gain
			return {
				message = "Fuck you Joe",
				message_card = card
			}
		end
	end
}
SMODS.Joker{
    key = 'neo', --joker key
    loc_txt = { -- local text
        name = '{C:purple,E:2}Ourpler{}',
        text = {
          '{C:purple,s:0.8}Ourpling{}',
		  'If the first {C:attention}hand{} has {C:attention}one card{}',
		  'Add a {C:purple}Purple Seal{} to it'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: kirb0s', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
	soul_pos = { x = 1, y = 1 },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 0},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_SEALS.Purple
	end,
	calculate = function(self,card,context)
		if context.scoring_hand ~= nil and G.GAME.current_round.hands_played == 0 then
			if context.individual and #context.full_hand == 1 and context.cardarea == G.play then
				context.other_card:set_seal("Purple",nil,true)
			end
		end
	end
}
SMODS.Joker{
    key = 'kirb', --joker key
    loc_txt = { -- local text
        name = 'Kirbos',
        text = {
          'Gives {C:mult}#1#{} Mult and {C:chips}#2#{} Chips',
		  'For every level the',
		  'played {C:attention}Poker{} {C:attention}hand{} has',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
	config = {
		extra = {
			mult = 2,
			chips = 5
		}
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.mult,
				center.ability.extra.chips
			}
		}
	end,
    atlas = 'Jokers', --atlas' key
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 6, y = 0},
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				mult_mod = (G.GAME.hands[context.scoring_name].level)*card.ability.extra.mult,
				chip_mod = (G.GAME.hands[context.scoring_name].level)*card.ability.extra.chips,
				message = "Kirbed!",
				message_card = card,
				card = card
			}
		end
	end
}
SMODS.Joker{
    key = 'yummi',
    loc_txt = {
        name = 'Sorry!',
        text = {
          'Upon selecting a {C:attention}Blind{} deletes itself',
		  'With a {C:green}chance{} of spawning 2 random {C:attention}Jokers{}',
		  '{C:inactive,s:0.8}Not Compatible with{} {C:green,s:0.8}Oops All 6s{}',
		  '{C:inactive,s:0.8}Does {}{C:red,s:0.8}NOT{}{C:inactive,s:0.8} need room{}'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 11, y = 0},
	calculate = function(self,card,context)
		if context.setting_blind then
			if math.random(1,2) == 1 then
				return {
					message = 'Fuck you Logger',
					message_card = card,
					G.jokers:remove_card(card),
					card:remove(),
					card = nil
				}
			else
				return {
					message = 'Fuck you Logger',
					message_card = card,
					G.jokers:remove_card(card),
					card:remove(),
					card = nil,
					SMODS.add_card {
						set = 'Joker',
						area = G.jokers,
					},
					SMODS.add_card {
						set = 'Joker',
						area = G.jokers
					}
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'bozo',
    loc_txt = {
        name = 'bozo!',
        text = {
			'If the first {C:attention}hand{} has {C:attention}one card{}',
        	'Change all {C:attention}Cards{} in {C:attention}hand{}',
			'To a random {C:attention}suit{} and {C:attention}rank{}',
			'{C:red}-#1#{} hand size'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 12, y = 0},
	config = { 
		extra = { 
			hand_size = 2 
		} 
	},
    loc_vars = function(self, info_queue, card)
        return { 
			vars = { 
				card.ability.extra.hand_size 
			} 
		}
    end,
	add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
	calculate = function(self,card,context)
		if context.scoring_hand ~= nil and G.GAME.current_round.hands_played == 0 then
			if context.joker_main and #context.full_hand == 1 then
				for i=1, #G.hand.cards do
					local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
				end
				delay(0.2)
				local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('sigil'))
				for i=1, #G.hand.cards do
					G.E_MANAGER:add_event(Event({func = function()
						local card = G.hand.cards[i]
						local suit_prefix = _suit..'_'
						local rank_suffix = card.base.id < 10 and tostring(card.base.id) or
											card.base.id == 10 and 'T' or card.base.id == 11 and 'J' or
											card.base.id == 12 and 'Q' or card.base.id == 13 and 'K' or
											card.base.id == 14 and 'A'
						card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
					return true end }))
				end  
				local _rank = pseudorandom_element({'2','3','4','5','6','7','8','9','T','J','Q','K','A'}, pseudoseed('ouija'))
				for i=1, #G.hand.cards do
					G.E_MANAGER:add_event(Event({func = function()
						local card = G.hand.cards[i]
						local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
						local rank_suffix =_rank
						card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
					return true end }))
				end
				for i=1, #G.hand.cards do
					local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.15,
						func = function() 
							G.hand.cards[i]:flip()
							play_sound('tarot2', percent, 0.6)
							G.hand.cards[i]:juice_up(0.3, 0.3)
							return true 
						end 
					}))
				end
				delay(0.5)
			end
		end
	end
}
SMODS.Joker{
	key = 'ragebait',
    loc_txt = {
        name = 'Rage Bait',
        text = {
          '{C:green}#1# in 2{} Chance on selecting a {C:attention}Blind{} to',
		  'produce a {C:dark_edition}Negative{} {C:attention}Joe{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 14, y = 0},
	config = { 
		extra = {
			odds = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe2
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.setting_blind and pseudorandom('nyx_ragebait') < G.GAME.probabilities.normal / card.ability.extra.odds then
			if math.random(1,2) == 1 then
				return {
					message = 'Rage Baiter!',
					message_card = card,
					SMODS.add_card {
						key = "j_nyx_joe",
						edition = 'e_negative'
					}
				}
			else 
				return {
					message = 'Rage Baiter!',
					message_card = card,
					SMODS.add_card {
						key = 'j_nyx_joe2',
						edition = 'e_negative'
					}
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'fuckbaron',
    loc_txt = {
        name = 'Fuck You Baron',
        text = {
          'Turns all played',
		  '{C:attention}Kings{} into {C:attention}Queens{}'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 17, y = 0},
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			for i=1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 13 then
					G.E_MANAGER:add_event(Event({
						func = function()
							assert(SMODS.change_base(context.scoring_hand[i], nil, "Queen"))
							return true
						end
					}))
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'milkmann',
    loc_txt = {
        name = 'The Milk Mann',
        text = {
          '{C:green}#2# in #1#{} Chance to {C:attention}create Milk{} when selecting {C:attention}blind{}',
		  '{C:green}Chance{} increases with every successful proc',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 18, y = 0},
	config = { 
		extra = {
			odds = 10
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_milk
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			if pseudorandom('nyx_milk') < G.GAME.probabilities.normal / card.ability.extra.odds then
				SMODS.add_card {
					key = 'j_nyx_milk'
				}
				if card.ability.extra.odds > 1 then
					card.ability.extra.odds = card.ability.extra.odds - 1
				end
				return {
					message = "Milk!",
					message_card = card
				}
			else
				return {
					message = "Fuck",
					message_card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'milk',
    loc_txt = {
        name = 'Milk',
        text = {
          'Gains {X:mult,C:white}#2#X{} Mult for every {C:attention}Milk{} owned',
		  '{C:green}#3# in #4#{} Chance to {C:red}not{} be {C:attention}consumed{}',
		  'when leaving the {C:attention}shop{}',
		  '{C:inactive,s:0.9}(Currently{} {X:mult,C:white,s:0.8}#1#X{} {C:inactive,s:0.8}Mult){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["FoodJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 1,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 19, y = 0},
	config = { 
		extra = {
			Xmult = 1,
			Xmult_gain = 0.2,
			odds = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.Xmult_gain,
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	in_pool = function(self)
		return false 
	end,
	set_ability = function(self, card, initial)
		card:set_edition('e_negative')
	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			card.ability.extra.Xmult = 1
			for i=1, #SMODS.find_card("j_nyx_milk")-1 do
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			end
		end
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
			}
		end
		if context.ending_shop and not (pseudorandom('nyx_milk') < G.GAME.probabilities.normal / card.ability.extra.odds) and not card.ability.eternal then
			return {
				message = "Drunk!",
				message_card = card,
				G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.destroy_cards{ card }
                        return true
                    end
                })) 
			}
		end
	end
}
SMODS.Joker{
	key = 'snakeeyes',
    loc_txt = {
        name = 'Snake Eyes',
        text = {
          '{C:red,E:2}You are unlucky{}'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 20, y = 0},
	add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v / 2
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = v * 2
        end
    end
}
SMODS.Joker{
	key = 'steamsale',
    loc_txt = {
        name = '{C:edition,E:1}Steam Sale{}',
        text = {
          '{C:dark_edition,E:1,s:2}EVERYTHING IS 50% OFF!{}',
		  '{C:red,s:0.5}Destroyed when leaving the shop{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 21, y = 0},
	config = { 
		extra = {
			discount = 50
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.discount
			}
		}
	end,
	remove_from_deck = function (self, card, from_debuff)
  		G.GAME.discount_percent = 0
	end,
	calculate = function(self,card,context)
		if G.shop then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.discount_percent = card.ability.extra.discount
					for _, v in pairs(G.I.CARD) do
						if v.set_cost then v:set_cost() end
					end
					return true
				end
			}))
		end
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards{ card }
					return true
				end
            })) 
		end
	end
}
SMODS.Joker{
	key = 'phi',
    loc_txt = {
        name = '{C:gold}Phi{}',
        text = {
          '{C:gold,s:1.2,E:2}The Golden Ratio{}',
		  'Scored {C:attention}Gold{} Cards give {X:mult,C:white}X#1#{}',
		  '{C:attention}Steel{} Cards in hand give {C:money}$#2#{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["MathJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 22, y = 0},
	config = { 
		extra = {
			Xmult = 1.5,
			money = 3
		}
	},
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_steel') or SMODS.has_enhancement(playing_card, 'm_gold') then
                return true
            end
        end
        return false
    end,
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_gold') then
			return {
                Xmult = card.ability.extra.Xmult,
				card = card
            }
		end
		if context.individual and context.cardarea == G.hand and context.other_card.config.center.key == 'm_steel' and not context.end_of_round then
			return {
                dollars = card.ability.extra.money
            }
		end
	end
}
SMODS.Joker{
    key = 'friend', --joker key
    loc_txt = { -- local text
        name = 'Friend', -- 
        text = {
          'Gives {C:mult}#4#{} Mult,',
		  'Gains {C:mult}+#5#{} Mult after every {C:attention}Blind{}',
		  'As your friend, he has a {C:green}#1# in #2#{} chance to give {C:money}$#6#{},', -- money
		  'and {C:green}#1# in #3#{} chance to create a {C:tarot}Tarot{} Card every hand played.',
		  '{C:inactive,s:0.7}snuggle... -w-{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers', --atlas' key
    rarity = 2, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 4, y = 1 },
    cost = 6, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 2}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
	config = { 
		extra = {
			odds1 = 3,
			odds2 = 6,
			mult = 4,
			mult_gain = 1,
			money = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds1,
				center.ability.extra.odds2,
				center.ability.extra.mult,
				center.ability.extra.mult_gain,
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		local dollarAmnt = 0
		if context.joker_main then
			if pseudorandom('nyx_friend') < G.GAME.probabilities.normal / card.ability.extra.odds1 then
				dollarAmnt = card.ability.extra.money
			end
			if pseudorandom('nyx_friend2') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
				return {
					message = 'My gift to you <3',
					colour = G.C.PURPLE,
					mult = card.ability.extra.mult,
					card = card
				},
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.0, func = function()
					play_sound('timpani')
					local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'car')
					card:add_to_deck()
					G.consumeables:emplace(card)
				return true end })),
				delay(0.6)
			end
			if dollarAmnt > 0 then
				return {
					colour = G.C.GREEN,
					dollars = dollarAmnt,
					mult = card.ability.extra.mult,
					card = card
				}
			else
				return {
					mult = card.ability.extra.mult,
					card = card,
				}
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = '+'..card.ability.extra.mult_gain..' Mult',
				colour = G.C.RED
			}
		end
	end
}
SMODS.Joker{
	key = 'towerheaven',
    loc_txt = {
        name = 'Tower of Heaven',
        text = {
		  'Gains {X:mult,C:white}X0.2{} Mult for every',
		  '{C:attention}Stone{} Card in deck',
		  '{C:inactive,s:0.8}Currently{} {X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 2},
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end,
	config = { 
		extra = {
			xmult = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		-- Always update
		card.ability.extra.xmult = 1
		for i=1, #G.playing_cards do
			if G.playing_cards[i].config.center.key == 'm_stone' then
				card.ability.extra.xmult = card.ability.extra.xmult + 0.2
			end
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'bellcurve',
    loc_txt = {
        name = 'Bell Curve',
        text = {
          'Converges the {C:attention}first{} and',
		  '{C:attention}last{} scored cards towards {C:attention}8{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 6, y = 2}, -- to the right of ERROR
	calculate = function(self,card,context)
		if context.before and context.main_eval and not context.blueprint then
			local first_card = context.scoring_hand[1]
			local last_card = context.scoring_hand[#context.scoring_hand]
			--Here comes some nyx code
			if tonumber(first_card:get_id()) > 8 then
					SMODS.modify_rank(first_card, -1)
					first_card:juice_up(0.3, 0.4)
					play_sound('card1')
			elseif tonumber(first_card:get_id()) < 8  then
				SMODS.modify_rank(first_card, 1)
					first_card:juice_up(0.3, 0.4)
					play_sound('card1')
			elseif tonumber(first_card:get_id()) == 8  then
				first_card:juice_up(0.3, 0.4)
				return {
					message = 'Already at 8',
					card = card,
					colour = G.C.PURPLE
				}
			end
			if context.scoring_hand[1] ~= context.scoring_hand[#context.scoring_hand] then
				if tonumber(last_card:get_id()) > 8 then
					SMODS.modify_rank(last_card, -1)
					last_card:juice_up(0.3, 0.4)
					play_sound('card1')
				elseif tonumber(last_card:get_id()) < 8 then
					SMODS.modify_rank(last_card, 1)
					last_card:juice_up(0.3, 0.4)
					play_sound('card1')
				elseif tonumber(last_card:get_id()) == 8 then
					last_card:juice_up(0.3, 0.4)
					return {
						message = 'Already at 8',
						card = card,
						colour = G.C.PURPLE
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'skippingstone',
    loc_txt = {
        name = 'Skipping Stone',
        text = {
          'Every {C:attention}other{} scored card is {C:attention}retriggered{}',
		  '{C:attention}Stone{} Cards are {C:attention}retriggered{} twice',
		  '{C:inactive,s:0.8}#3#',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 7, y = 2}, -- to the right of Bell Curve
	config = {
		extra = {
			count = 0,
			repetitions = 1
		},
		info = "(First scored card will not trigger this hand - Changes every hand)"
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.count,
				center.ability.extra.repetitions,
				self.config.info
			}
		}
	end,
	calculate = function(self,card,context)
		-- Updated logic
		local repeats = card.ability.extra.repetitions
		for i = 1, 5 do
			if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[i] then
				if context.scoring_hand[i].config.center.key == 'm_stone' then
					repeats = 2
				else
					repeats = 1
				end
				if card.ability.extra.count % 2 == 1 then
					self.config.info = "(First scored card will not trigger this hand - Changes every hand)"
				else
					self.config.info = "(First scored card will trigger this hand - Changes every hand)"
				end
				card.ability.extra.count = card.ability.extra.count + 1
				if card.ability.extra.count % 2 == 0 then
					return {
						repetitions = repeats,
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'stop',
    loc_txt = {
        name = 'Stop Sign',
        text = {
			'Gives {X:mult,C:white}X2{} Mult, but {C:red}debuffs{} the {C:attention}Joker{} to the left',
			'{s:0.8}Does not update immediately{}',
			'{C:red,s:0.8}Will destroy its own duplicates{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 9, y = 2}, -- to the right of (not used yet)
	config = {
		extra = {
			xmult = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		-- Destroy duplicates
		-- I, bozo64_, come up with the best solution for bug fixes.
		local hasDeleted = false
		for i = 1, #G.jokers.cards do
			local other_joker = G.jokers.cards[i]
			if other_joker.config.center.key == 'j_nyx_stop' and other_joker ~= card then
				G.jokers:remove_card(other_joker)
				other_joker:remove()
				hasDeleted = true
				return {
					message = "There can only be one.",
					colour = G.C.RED,
					card = nil
				}
			end
		end

		-- Do mult thing
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
			}
		end

		if not hasDeleted then
			-- Locate stop sign position
			local stopIndex = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					stopIndex = i
					break
				end
			end

			-- Debuff joker to left
			if stopIndex > 1 then
				local jokerToDebuff = G.jokers.cards[stopIndex - 1]

				-- You cannot beat ERROR.
				if jokerToDebuff.config.center.key ~= 'j_nyx_err' then
					SMODS.debuff_card(jokerToDebuff, true, "stopsign")
				end
			end

			-- Undebuff other jokers
			for i = 1, #G.jokers.cards do
				if i ~= stopIndex and i ~= stopIndex - 1 then
					local joker = G.jokers.cards[i]
					local canUndebuff = true

					-- Check if joker is chosen by crimson heart or has perished
					if joker.ability.perishable then
						if joker.ability.perish_tally <= 0 then
							canUndebuff = false
						end
					end

					if joker.ability.crimson_heart_chosen then
						canUndebuff = false
					end

					if canUndebuff then
						SMODS.debuff_card(joker, false, "stopsign")
					end
				end
			end
		end
	end
}

local corruptedText = {}
for i = 1, 100 do
	local corruptedString = ''
    for i = 0, math.random(7, 25) do
        corruptedString = corruptedString .. string.char(math.random(15, 90))
    end
	table.insert(corruptedText, corruptedString)
end

-- Error text
-- 'When {X:chips,C:mult}' .. corruptedText[math.random(1, #corruptedText)] .. '{}',
-- '{X:chips,C:purple}Blind{} {X:mult,C:inactive}' .. corruptedText[math.random(1, #corruptedText)] .. '{} {C:mult}mult{} after',
-- 'every {X:mult,C:chips}' .. corruptedText[math.random(1, #corruptedText)] .. '{}'

local randomWords = {'Jo  ker', 'unde fined    ', 'broken', 'SJKFSUQ   ', '   Func tional Nyx', 'ER  ROR', '-face', 'Plac   eholder', 'Misprint  ', 'MESSAGE   ', 'UNK   NOWN', '34   213551', 'meani   ng', 'TRU  E', 'FAL  SE', 'Gi  ves', '  bozo!', 'I', 'F0U ND', 'Y0U'}
local colors = {G.C.RED, G.C.GREEN, G.C.BLUE, G.C.YELLOW, G.C.PURPLE, G.C.ORANGE, G.C.PINK, G.C.BROWN} -- unused
local suits = {'Spades', 'Hearts', 'Diamonds', 'Clubs'}
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'}
local rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}
local enhancements = {'m_bonus','m_mult','m_wild','m_glass','m_steel','m_stone','m_gold','m_lucky','m_nyx_diseased','m_nyx_frozen','m_nyx_truelucky','m_nyx_burning','m_nyx_wet','m_nyx_starcrossed'}
local editions = {'e_negative','e_polychrome','e_foil','e_holo'}
local seals = {'Red', 'Blue', 'Gold','Purple','nyx_greenseal','nyx_greenblue'}

SMODS.Joker { -- This joker should be referred to as "ERROR"
	key = 'err',
    loc_txt = {
        name = '#5#',
        text = {
			'When {X:chips,C:mult}#1#{}',
			'#2# {X:chips,C:purple}Blind{} {X:purple,C:inactive}#3#{} {C:mult}mult{} after',
			'every {X:mult,C:white}#4#{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: #2#', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 1, -- why were u 20 dollars
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 2},
	config = {
		sec1 = "Test",
		sec2 = "test",
		sec3 = "testing",
		sec4 = "bleh",
		name = 'ERROR',
		extra = {
			mult = 1,
			chips = 1,
			Xmult = 1
		}
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				self.config.sec1,
				self.config.sec2,
				self.config.sec3,
				self.config.sec4,
				self.config.name
			}
		}
	end,
	calculate = function(self, card, context)
		-- Destroy duplicates
		-- I, bozo64_, come up with the best solution for bug fixes.
		local hasDeleted = false
		for i = 1, #G.jokers.cards do
			local other_joker = G.jokers.cards[i]
			if other_joker.config.center.key == 'j_nyx_err' and other_joker ~= card then
				G.jokers:remove_card(other_joker)
				other_joker:remove()
				hasDeleted = true
				return {
					message = corruptedText[math.random(1, #corruptedText)],
					colour = G.C.RED
				}
			end
		end

		local isCorruptedDeck = G.GAME.selected_back.effect.center.key == "b_nyx_corruptedDeck"

		if isCorruptedDeck then
			if not card.ability.eternal then
				SMODS.Stickers.eternal:apply(card, true)
			end
		end

		if context.cardarea == G.jokers then
			-- Debuff stop sign if it is in front of ERROR
			local stopIndex = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].config.center.key == 'j_nyx_stop' then
					stopIndex = i
					break
				end
			end

			local errorIndex = 0
			if stopIndex ~= 0 then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i].config.center.key == 'j_nyx_err' then
						errorIndex = i
					end

					if errorIndex ~= #G.jokers.cards and errorIndex > 0 then
						if G.jokers.cards[errorIndex+1].config.center.key == 'j_nyx_stop' then
							SMODS.debuff_card(G.jokers.cards[stopIndex], true, "error")
						else
							SMODS.debuff_card(G.jokers.cards[stopIndex], false, "error")
						end
					end
				end
			end
		end

		if context.before then
			-- Do a random effect
			local choiceCount = 9 -- Just an easy variable I can change on the fly with each chaos effect I add
			local rareChoices = 18
			local random = pseudorandom('nyx_error')

			-- 15% chance to do a rare effect, 60% on invalid deck
			if pseudorandom('rareeffect') < 0.85 and not (G.GAME.selected_back.effect.center.key == "b_nyx_corruptedDeck" and pseudorandom('rareeffect') > 0.4) then
				if random < 1 / choiceCount then -- Do literally nothing
				elseif random < 1 / choiceCount*2 then -- Randomize rank of a random card
					local randomCard = math.floor(pseudorandom('randomCard')*#context.scoring_hand)+1

					G.E_MANAGER:add_event(Event({
						func = function()
							assert(SMODS.change_base(context.scoring_hand[randomCard], nil, ranks[math.random(1, #ranks)]))
							return true
						end
					}))

					-- Also have a 1/2 chance to change the suit
					if pseudorandom('nyx_error2') < 1 / 2 then
						G.E_MANAGER:add_event(Event({
							func = function()
								assert(SMODS.change_base(context.scoring_hand[randomCard], suits[math.random(1, #suits)], nil))
								return true
							end
						}))
					end
				elseif random < 1 / choiceCount*3 then -- Reverse of first effect
					local randomCard = math.floor(pseudorandom('randomCard')*#context.scoring_hand)+1

					G.E_MANAGER:add_event(Event({
						func = function()
							assert(SMODS.change_base(context.scoring_hand[randomCard], suits[math.random(1, #suits)], nil))
							return true
						end
					}))

					-- Also have a 1/2 chance to change the rank
					if pseudorandom('nyx_error2') < 1 / 2 then
						G.E_MANAGER:add_event(Event({
							func = function()
								assert(SMODS.change_base(context.scoring_hand[randomCard], nil, ranks[math.random(1, #ranks)]))
								return true
							end
						}))
					end
				elseif random < 1 / choiceCount*4 then -- Give or take 3 dollars
					if pseudorandom('nyx_error2') < 1 / 2 then
						return {
							dollars = 3
						}
					else
						return {
							dollars = -3
						}
					end
				elseif random < 1 / choiceCount*5 then -- Duplicate a random card
					local randomCard = math.floor(pseudorandom('randomCard')*#context.scoring_hand)+1

					local card = copy_card(context.scoring_hand[randomCard], nil)
					card:start_materialize()
					card:add_to_deck()
					G.hand:emplace(card)
				elseif random < 1 / choiceCount*6 then -- Destroys a random card
					local randomCard = math.floor(pseudorandom('randomCard')*#context.scoring_hand)+1
					local card = context.scoring_hand[randomCard]

					SMODS.destroy_cards(card)
					card:start_dissolve()
				elseif random < 1 / choiceCount*7 then -- Give or take a hand
					if pseudorandom('nyx_error2') < 1 / 2 then
						G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
					else
						G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
					end
				elseif random < 1 / choiceCount*8 then -- Give or take a discard
					if pseudorandom('nyx_error2') < 1 / 2 then
						G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
					else
						G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
					end		
				elseif random < 1 / choiceCount*9 then -- Multiply various values by a random float between 0.5 - 1.5
					G.GAME.round_resets.hands = G.GAME.round_resets.hands * (pseudorandom("error") + 0.5)
					G.GAME.round_resets.discards = G.GAME.round_resets.discards * (pseudorandom("error") + 0.5)
					G.GAME.dollars = G.GAME.dollars * (pseudorandom("error") + 0.5)
					G.GAME.blind.chips = G.GAME.blind.chips * (pseudorandom("error") + 0.5)

					if G.GAME.round_resets.hands < 2 then
						G.GAME.round_resets.hands = G.GAME.round_resets.hands * 2.5
					end
				end

				return {
					message = corruptedText[math.random(1, #corruptedText)]
				}


			else ------------------- RARE EFFECTS ----------------------------

			
				if random < 1 / rareChoices then -- Copy random card to joker slots
					local randomCard = math.floor(pseudorandom('randomCard')*#context.scoring_hand)+1

					local card = copy_card(context.scoring_hand[randomCard], nil)
					card:start_materialize()
					card:add_to_deck()
					SMODS.Stickers["nyx_corrupted"]:apply(card, true)
					G.jokers:emplace(card)
				elseif random < 1 / rareChoices*2 then -- Destroy all played cards
					for i = 1, #context.scoring_hand do
						local card = context.scoring_hand[i]

						SMODS.destroy_cards(card)
						card:start_dissolve()
					end
				elseif random < 1 / rareChoices*3 then -- Create a friend
					SMODS.add_card {
						key = 'j_nyx_friend',
						stickers = {'nyx_corrupted'}
					}
				elseif random < 1 / rareChoices*4 then -- Copy random card to screen (???)
					local randomCard = math.floor(pseudorandom('randomCard')*#context.scoring_hand)+1

					local card = copy_card(context.scoring_hand[randomCard], nil)
					card:start_materialize()
					card:add_to_deck()
				elseif random < 1 / rareChoices*5 and not (G.GAME.selected_back.effect.center.key == "b_nyx_corruptedDeck") then -- Delete a random joker that ISN'T ERROR
					-- Don't delete jokers on invalid deck
					if #G.jokers.cards > 1 then
						local which = math.floor(pseudorandom('rerollJoker')*(#G.jokers.cards-1))+1
					
						for i=1, #G.jokers.cards do -- for all jokers
							if G.jokers.cards[i] == card and i == which then -- not itself
								which = which + 1
							end

							if i == which then
								local other_joker = G.jokers.cards[i]
								other_joker:remove()
								other_joker:start_dissolve()
							end
						end
					else
						return {
							message = "err"
						}
					end
				elseif random < 1 / rareChoices*6 then -- Reroll a random joker that ISN'T ERROR
					if #G.jokers.cards > 1 then
						local which = math.floor(pseudorandom('rerollJoker')*(#G.jokers.cards-1))+1
					
						for i=1, #G.jokers.cards do -- for all jokers
							if G.jokers.cards[i] == card and i == which then -- not itself
								which = which + 1
							end

							if i == which then
								local other_joker = G.jokers.cards[i]

								-- Don't replace joker if it is another ERROR or is oops all 6s
								if other_joker.config.center.key ~= "j_nyx_err" then
									-- Retain edtion, don't replace eternals
									local jokerEditions = other_joker.edition
									local jokerRarity = other_joker.config.center.rarity
									local jokerStickers = {}

									if other_joker.ability.eternal then
										table.insert(jokerStickers, 'eternal')
									end
									if other_joker.ability.perishable then
										table.insert(jokerStickers, 'perishable')
									end
									if other_joker.ability.rental then
										table.insert(jokerStickers, 'rental')
									end

									other_joker:remove()
									SMODS.add_card{
										set = 'Joker',
										area = G.jokers,
										edition = jokerEditions,
										stickers = jokerStickers,
										rarity = rarities[jokerRarity]
									}
								else
									return {
										message = "could not index null"
									}
								end
							end
						end
					else
						return {
							message = "err"
						}
					end
				elseif random < 1 / rareChoices*7 then -- Duplicate a random joker that ISN'T ERROR
					if #G.jokers.cards > 1 then
						local which = math.floor(pseudorandom('rerollJoker')*(#G.jokers.cards-1))+1
					
						for i=1, #G.jokers.cards do -- for all jokers
							if G.jokers.cards[i] == card and i == which then -- not itself
								which = which + 1
							end

							if i == which then
								local other_joker = G.jokers.cards[i]
								local card = copy_card(other_joker, nil)
								card:start_materialize()
								card:add_to_deck()
								SMODS.Stickers["nyx_corrupted"]:apply(card, true)
								G.jokers:emplace(card)
							end
						end
					else
						return {
							message = "err"
						}
					end
				elseif random < 1 / rareChoices*8 then -- Put a joker in hand
					if #G.jokers.cards > 1 then
						local which = math.floor(pseudorandom('rerollJoker')*(#G.jokers.cards-1))+1
					
						for i=1, #G.jokers.cards do -- for all jokers
							if G.jokers.cards[i] == card and i == which then -- not itself
								which = which + 1
							end

							if i == which then
								local other_joker = G.jokers.cards[i]
								local card = copy_card(other_joker, nil)
								card:start_materialize()
								card:add_to_deck()
								G.hand:emplace(card)
							end
						end
					else
						return {
							message = "err"
						}
					end
				elseif random < 1 / rareChoices*9 then -- Set hands to 0
					G.GAME.current_round.hands_left = 0
				elseif random < 1 / rareChoices*10 then -- Duplicate joker to consumable slots
					if #G.jokers.cards > 1 then
						local which = math.floor(pseudorandom('rerollJoker')*(#G.jokers.cards-1))+1
					
						for i=1, #G.jokers.cards do -- for all jokers
							if G.jokers.cards[i] == card and i == which then -- not itself
								which = which + 1
							end

							if i == which then
								local other_joker = G.jokers.cards[i]
								local card = copy_card(other_joker, nil)
								card:start_materialize()
								card:add_to_deck()
								SMODS.Stickers["nyx_nulled"]:apply(card, true)
								G.consumeables:emplace(card)
							end
						end
					else
						return {
							message = "err"
						}
					end
				elseif random < 1 / rareChoices*11 then -- Create an eternal negative joement
					SMODS.add_card {
						key = 'j_nyx_joe',
						edition = "e_negative",
						stickers = {"eternal"}
					}
				elseif random < 1 / rareChoices*12 and not (G.GAME.selected_back.effect.center.key == "b_nyx_corruptedDeck") then
					-- Win blind instantly (produces glitchy results but i love it)
					-- Do nothing on the corrupted deck
					G.GAME.chips = G.GAME.blind.chips
					G.STATE = G.STATES.HAND_PLAYED
					G.STATE_COMPLETE = true
					end_round()
					return nil
				elseif random < 1 / rareChoices*13 and not (G.GAME.selected_back.effect.center.key == "b_nyx_corruptedDeck") then -- Set money to 0
					return {
						ease_dollars(-G.GAME.dollars, true),
						card = card
					}
				elseif random < 1 / rareChoices*14 then -- Give scored cards random enhancements
					for i=1, #context.scoring_hand do
						local percent = 1.15 - (i-0.999)/(#context.scoring_hand-0.998)*0.3
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() play_sound('card1', percent);context.scoring_hand[i]:juice_up(0.3, 0.3);return true end }))
					end
					local enhancements = {
						'm_bonus',
						'm_mult',
						'm_wild',
						'm_glass',
						'm_steel',
						'm_stone',
						'm_gold',
						'm_lucky',
						'm_nyx_diseased',
						'm_nyx_frozen'
					}
					for i=1, #context.scoring_hand do
						if not SMODS.has_enhancement(context.scoring_hand[i]) then
							context.scoring_hand[i]:set_ability(G.P_CENTERS[enhancements[math.random(1, #enhancements)]])
						end
					end
					for i=1, #context.scoring_hand do
						local percent = 0.85 + (i-0.999)/(#context.scoring_hand-0.998)*0.3
					end
					delay(0.5)
				elseif random < 1 / rareChoices*15 then -- Make scored cards negative
					for i = 1, #context.scoring_hand do
						context.scoring_hand[i]:set_edition({ negative = true })
					end
				elseif random < 1 / rareChoices*16 then -- Give or take a joker slot
					if pseudorandom('nyx_error') < 1 / 2 then
						G.jokers.config.card_limit = G.jokers.config.card_limit + 1
					else
						G.jokers.config.card_limit = G.jokers.config.card_limit - 1
					end
				elseif random < 1 / rareChoices*17 then -- Give or take a consumable slot
					if pseudorandom('nyx_error') < 1 / 2 then
						G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
					else
						G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
					end
				elseif random < 1 / rareChoices*18 then -- Increase or decrease hand size
					if pseudorandom('nyx_error') < 1 / 2 then
						G.hand:change_size(1)
					else
						G.hand:change_size(-1)
					end
				end
				
				return {
					message = "could not index null",
					colour = G.C.RED
				}
			end
		end

		-- if context.end_of_round and context.cardarea == G.jokers then
		-- 	return {
		-- 		dollars = math.random(-5, 6),
		-- 	}
		-- end
    end,
	update = function(self, card, dt)
		self.config.sec1 = corruptedText[math.random(1, #corruptedText)]
		self.config.sec2 = corruptedText[math.random(1, #corruptedText)]
		self.config.sec3 = corruptedText[math.random(1, #corruptedText)]
		self.config.sec4 = corruptedText[math.random(1, #corruptedText)]

		-- Mash text together
		local newName = ""
		for i = 1, math.random(2, 6) do 
			local randomWord = randomWords[math.random(1, #randomWords)]
			local newRandomWord = ""
			local startPos = math.random(1, #randomWord/2)
			for i = startPos, startPos + math.random(1, #randomWord/2) do
				newRandomWord = newRandomWord .. string.sub(randomWord, i, i)
			end
			newName = newName .. newRandomWord
		end

		self.config.name = newName
	end
}
SMODS.Joker{
	key = 'deadend',
    loc_txt = {
        name = 'Dead End',
        text = {
          '{X:mult,C:white}X#1#{} Mult if you have no cards held in hand'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 11, y = 2},
	config = { 
		extra = {
			xmult = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return {
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			if G.hand.cards and #G.hand.cards == 0 then
				return {
					x_mult = card.ability.extra.xmult,
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'doctor',
    loc_txt = {
        name = 'Doctor',
        text = {
		  'Gains {X:mult,C:white}X#2#{} Mult for every {C:attention}Diseased{} card destroyed',
		  '{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 15, y = 2},
	config = { 
		extra = {
			xmult = 1,
			xmult_gain = 0.25
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_nyx_diseased
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.xmult_gain
			}
		}
	end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_nyx_diseased') then
                return true
            end
        end
        return false
    end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
		if context.remove_playing_cards and not context.blueprint then
			local count = 0
            for _, removed_card in ipairs(context.removed) do
                if SMODS.has_enhancement(removed_card, 'm_nyx_diseased') then 
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
					count = count + 1
				end
            end
			if count > 0 then
				return {
					message = "X" .. card.ability.extra.xmult,
					message_card = card,
					colour = G.C.MULT
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'dtwenty',
    loc_txt = {
        name = 'D20',
        text = {
          'Rerolls the {C:attention}Joker{} to the right',
		  'when you {C:attention}reroll{} in the shop',
		  '{C:inactive,s:0.8}Does not reroll editions or stickers{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 20, y = 2},
	calculate = function(self,card,context)
		if context.reroll_shop and context.cardarea == G.jokers then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i + 1].config.center.key ~= 'j_nyx_err' then
					if G.jokers.cards[i] == card and G.jokers.cards[i + 1] then
						local next_joker = G.jokers.cards[i + 1]
						if next_joker then
							local jokerEditions = next_joker.edition
							local jokerStickers = {}

							if next_joker.ability.eternal then
								table.insert(jokerStickers, 'eternal')
							end
							if next_joker.ability.perishable then
								table.insert(jokerStickers, 'perishable')
							end
							if next_joker.ability.rental then
								table.insert(jokerStickers, 'rental')
							end

							next_joker:remove()
							SMODS.add_card{
								set = 'Joker',
								area = G.jokers,
								edition = jokerEditions,
								stickers = jokerStickers
							}

							return {
								message = "Rerolled!",
								message_card = card,
								colour = G.C.GREEN
							}
						end
					end
				elseif G.jokers.cards[i] == card then -- Reroll self
					local jokerEditions = card.edition
					local jokerStickers = {}

					if card.ability.eternal then
						table.insert(jokerStickers, 'eternal')
					end
					if card.ability.perishable then
						table.insert(jokerStickers, 'perishable')
					end
					if card.ability.rental then
						table.insert(jokerStickers, 'rental')
					end

					card:remove()
					SMODS.add_card{
						set = 'Joker',
						area = G.jokers,
						edition = jokerEditions,
						stickers = jokerStickers
					}

					return {
						message = "ERROR",
						message_card = card,
						colour = G.C.GREEN
					}
				end
			end
			if G.jokers.cards[#G.jokers.cards] == card then
				local ran = math.random(1, 20)
				card:juice_up(0.5, 0.5)
				if ran == 20 then
					local st = 0.50
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = st,
						func = function()
							card:juice_up(0.5, 0.5)
						return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = st/2,
						func = function()
							card:juice_up(0.5, 0.5)
						return true
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 2,
						func = function()
							SMODS.destroy_cards{card}
							SMODS.add_card {
								key = 'j_nyx_loadeddice',
								area = G.jokers
							}
							return true
						end
					}))
				else 
					return {
						message = "" .. tostring(ran) .. "!",
						message_card = card,
						colour = G.C.YELLOW
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'vending',
    loc_txt = {
        name = 'Vending Machine',
        text = {
          'When leaving the {C:attention}shop{} takes {C:money}$#1#{}',
		  'But has a {C:green}#2# in #3#{} chance',
		  'to create a random {C:attention}Food{} Joker',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true,
		["FoodJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 7, y = 3},
	config = { 
		extra = {
			cost = 1,
			odds = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.cost,
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.ending_shop then
			if pseudorandom('nyx_vending') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return { -- bozo code gone!
					SMODS.add_card {
						set = 'FoodJokers',
						area = G.jokers,
					},
					dollars = -card.ability.extra.cost,
					card = card
				}
			else
				return {
					message_card = card,
					message = "Jammed!",
					dollars = -card.ability.extra.cost,
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'Aurafarm',
    loc_txt = {
        name = 'Aura Farm',
        text = {
          '{C:green}#1# in #2#{} chance for each played {C:attention}Ace{}',
		  'to create an {C:spectral}Aura{} card when scored',
		  '{C:inactive,s:0.8}(Must have room){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 13, y = 3},
	config = { 
		extra = {
			odds = 4
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if (context.other_card:get_id() == 14) and (pseudorandom('nyx_aurafarm') < G.GAME.probabilities.normal / card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_spectral'),
                        message_card = card,
						colour = G.C.SECONDARY_SET.Spectral,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        key = 'c_aura'
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
	end
}
SMODS.Joker{
	key = 'construction',
    loc_txt = {
        name = 'Under Construction',
        text = {
          'Gives {C:money}$#1#{} for each empty joker slot'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 2,
    cost = 0,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 16, y = 3},
	config = { 
		extra = {
			money = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money,
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			local moneyGiven = G.jokers.config.card_limit * card.ability.extra.money

			for i = 1, #G.jokers.cards do
				moneyGiven = moneyGiven - card.ability.extra.money
			end
			return {
				dollars = moneyGiven
			}
		end
	end
}
SMODS.Joker{
	key = 'salestar',
    loc_txt = {
        name = 'Sale Star',
        text = {
          'The {C:attention}Shop{} has {C:attention}#1#{}',
		  'extra slots when {C:attention}entering{}',
		  '{C:attention,s:0.8}Rerolling{}{C:inactive,s:0.8} the shop will {}{C:red,s:0.8}remove{}{C:inactive,s:0.8} this bonus{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 22, y = 3},
	config = { 
		extra = {
			slots = 2,
			reroll = false
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.slots,
				center.ability.extra.reroll
			}
		}
	end,
	calculate = function(self, card, context)
		if context.starting_shop then
			G.GAME.shop.joker_max = G.GAME.shop.joker_max - card.ability.extra.slots
			card.ability.extra.reroll = true
		end
		if context.reroll_shop and context.cardarea == G.jokers then
			if G.GAME.shop.joker_max < 2 then
				G.GAME.shop.joker_max = 2
			end
		end
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.GAME.shop.joker_max = G.GAME.shop.joker_max + card.ability.extra.slots
					card.ability.extra.reroll = false
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'gummies',
    loc_txt = {
        name = 'Vitamin Gummies',
        text = {
          '{X:mult,C:white}X#1#{} Mult but decreases by {X:mult,C:white}X0.25{} every hand',
		  "{C:inactive,E:1,s:0.8}You know you're only supposed to eat 2 a day right?{}",
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true,
		["FoodJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 7, y = 4},
	config = { 
		extra = {
			Xmult = 2.5,
			Xmult_loss = 0.25
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.Xmult_loss
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
            }
		end
		if context.after and not context.blueprint then
			card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_loss
			if card.ability.extra.Xmult == 1 then
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.destroy_cards{ card }
						return true
					end
				}))
				return {
					message = 'Eaten!'
				}
			else
				return {
					message = '-X'..card.ability.extra.Xmult_loss,
					colour = G.C.RED
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'discordmod',
    loc_txt = {
        name = 'Discord Mod',
        text = {
          'Gives {C:money}$5{} every {C:blue}hand{}',
		  'but debuffs {C:attention}adjacent{} Jokers',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 6, y = 4},
	config = { 
		extra = {
			money = 5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money
			}
		}
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- Undebuff all jokers on removal
		for i = 1, #G.jokers.cards do
			local joker = G.jokers.cards[i]
			local canUndebuff = true

			-- Check if joker is chosen by crimson heart or has perished
			if joker.ability.perishable then
				if joker.ability.perish_tally <= 0 then
					canUndebuff = false
				end
			end

			if joker.ability.crimson_heart_chosen then
				canUndebuff = false
			end

			if canUndebuff then
				SMODS.debuff_card(joker, false, "discordmod")
			end
		end
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				dollars = card.ability.extra.money,
				card = card
			}
		end
		local stopIndex = 0
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				stopIndex = i
				break
			end
		end

		-- Debuff joker to left
		if stopIndex > 1 then
			local jokerToDebuff = G.jokers.cards[stopIndex - 1]

			-- You cannot beat ERROR.
			if jokerToDebuff.config.center.key ~= 'j_nyx_err' then
				SMODS.debuff_card(jokerToDebuff, true, "discordmod")
			end
		end

		if G.jokers.cards[stopIndex + 1] then
			local jokerToDebuff = G.jokers.cards[stopIndex + 1]

			-- You cannot beat ERROR.
			if jokerToDebuff.config.center.key ~= 'j_nyx_err' then
				SMODS.debuff_card(jokerToDebuff, true, "discordmod")
			end
		end

		-- Undebuff other jokers
		for i = 1, #G.jokers.cards do
			if i ~= stopIndex and i ~= stopIndex - 1 and i ~= stopIndex + 1 then
				local joker = G.jokers.cards[i]
				local canUndebuff = true

				-- Check if joker is chosen by crimson heart or has perished
				if joker.ability.perishable then
					if joker.ability.perish_tally <= 0 then
						canUndebuff = false
					end
				end

				if joker.ability.crimson_heart_chosen then
					canUndebuff = false
				end

				if canUndebuff then
					SMODS.debuff_card(joker, false, "discordmod")
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'cosmicmap',
    loc_txt = {
        name = 'Cosmic Map',
        text = {
        	'If 5 cards are {C:attention}Scored{}',
			'Enhance the middle card to',
			'be {C:attention}Star-Crossed{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 8, y = 4},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_nyx_starcrossed']
    end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			if #context.scoring_hand >= 5 and context.other_card == context.scoring_hand[3] then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						context.scoring_hand[3]:set_ability(G.P_CENTERS.m_nyx_starcrossed)
						context.scoring_hand[3]:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
		end
	end
}
SMODS.Joker{
	key = 'buy1get1',
    loc_txt = {
        name = 'Buy 1 Get 1 Free!',
        text = {
		  'Able to play {C:blue}6{} cards'
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 18, y = 4},
	config = { 
		extra = {
			limit = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.limit
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + (card.ability.extra.limit)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + (card.ability.extra.limit)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + (-1 * card.ability.extra.limit)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + (-1 * card.ability.extra.limit)
		if not G.GAME.before_play_buffer then
			G.hand:unhighlight_all()
		end
	end
}
SMODS.Joker{
	key = 'taskmanager',
    loc_txt = {
        name = 'Task Manager',
        text = {
          '{C:mult}Destroys{} all played',
		  '{C:attention}debuffed cards{}',
		  'Gain {C:mult}#2# Mult{} for each',
		  '{C:attention}debuffed card destroyed{}',
		  '{C:inactive,s:0.8}(Currently {}{C:mult,s:0.8}+#1#{} {C:inactive,s:0.8}Mult){}',
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 21, y = 4},
	config = { 
		extra = {
			mult = 0,
			mult_gain = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return {
			vars = {
				center.ability.extra.mult,
				center.ability.extra.mult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		if context.destroy_card then
			
			for i = 1, #context.full_hand do
				local car = context.full_hand[i]

				if car.debuff and context.destroy_card == car then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
					
					return {
						remove = true
					}
				end
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
	end
}

-- Rare --
SMODS.Joker{
    key = 'AEOM', --joker key
    loc_txt = { -- local text
        name = 'All Eyes On Me',
        text = {
          'All {C:attention}face{} Cards',
          'Grant {X:mult,C:white}X#1#{} Mult'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers', --atlas' key
    rarity = 3, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    --soul_pos = { x = 0, y = 0 },
    cost = 8, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 0, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
	config = { 
		extra = {
			Xmult = 1.5,
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {center.ability.extra.Xmult}
		}
	end,
	calculate = function(self,card,context)
		 if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
				return {
					card = card,
					Xmult = card.ability.extra.Xmult,
					colour = G.C.MULT
				}
			end
        end
	end
}
SMODS.Joker{
    key = 'nicky', --joker key
    loc_txt = { -- local text
        name = 'The Nickle Monster',
        text = {
          'Either {X:mult,C:white}XMult{} of {X:mult,C:white}50{} or {X:mult,C:white}0.02{}',
		  '{C:inactive,s:0.8}Not Compatible with {}{C:green,s:0.8}Oops All 6s{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 9, y = 0},
	calculate = function(self,card,context)
		if context.joker_main then
			if math.random(1, 2) == 1 then 
				return {
					Xmult = 50,
					card = card
				}
			else 
				return {
					Xmult = 0.02,
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
    key = 'straz', --joker key
    loc_txt = { -- local text
        name = '{C:red}Beastmode{}',
        text = {
          'There can only be {C:red}one{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 7, y = 0},
	config = { 
		extra = {
			Xmult = 5,
			odds = 10
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		local hasDeleted = false
		for i = 1, #G.jokers.cards do
			local other_joker = G.jokers.cards[i]
			if other_joker.config.center.key == 'j_nyx_straz' and other_joker ~= card then
				G.jokers:remove_card(other_joker)
				other_joker:remove()
				hasDeleted = true
				card.ability.extra.Xmult = card.ability.extra.Xmult + 5
				return {
					message = "There can only be one.",
					colour = G.C.RED,
					card = nil
				}
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not hasDeleted then
			if pseudorandom('nyx_straz') < G.GAME.probabilities.normal / card.ability.extra.odds and not card.ability.eternal then
				G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.destroy_cards{ card }
                        return true
                    end
                })) 
				return {
					message = "Sniped!",
                    colour = G.C.RED
				}
			else 
				return {
					message = 'Nah, Id Win™'
				}
			end
		end
		if context.joker_main then 
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'pentagram',
    loc_txt = {
        name = 'Pentagram',
        text = {
          'Scoring cards of rank {C:attention}6{}',
		  'give {X:mult,C:white}X#1#{} Mult'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 10, y = 2}, -- to the right of Stop sign
	config = {
		extra = {
			xmult = 1.66
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 6 then
				return {
					x_mult = card.ability.extra.xmult,
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'blankcheck',
    loc_txt = {
        name = 'Blank Check',
        text = {
          'All {C:attention}scored{} cards give {C:money}$#1#{}',
		  '{C:green}#2# in #3#{} Chance to set money to {C:red}0{} after each hand',
		  "{C:inactive,s:0.8}You're not supposed to have this you know{}",
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 12, y = 2},
	config = { 
		extra = {
			money = 1,
			odds = 6
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money,
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.odds
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			return {
				dollars = card.ability.extra.money,
				card = card
			}
		end
		if context.after and not context.blueprint then
			if pseudorandom('nyx_blank') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					ease_dollars(-G.GAME.dollars, true),
					card = card
				}
			end
		end
	end
}
SMODS.Joker{
	key = 't',
    loc_txt = {
        name = 't',
        text = {
          '{C:green}#1# in #2#{} Chance to {C:red}Multiply{}',
		  'all {C:attention}Joker{} values by {C:red}#3#{}',
		  '{C:red,E:2}Self Destructs{}',
		  '{C:inactive,s:0.8}[3:18 PM] nyx: Now I need to figure out a name for it....{}',
		  '{C:inactive,s:0.8}[6:03 PM] bozo!: t{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 3},
	config = { 
		extra = {
			odds = 12,
			multiplier = 1.5
		}
	},
	loc_vars = function(self,info_queue,card)
		return {vars = {G.GAME.probabilities.normal,card.ability.extra.odds, card.ability.extra.multiplier}}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then 
			local _card = card
			if pseudorandom('fuck you nyx') < G.GAME.probabilities.normal / card.ability.extra.odds then
				for i = 1, #G.jokers.cards do
					local exclude_extra = {"Runner","Square Joker","Wee Joker","Invisible Joker"}
					local doExclude = false
					for e = 1 , #exclude_extra do
						if G.jokers.cards[i].ability.name == exclude_extra[e]then
							doExclude = true
						end
					end
					if G.jokers.cards[i].ability.name ~= "j_nyx_t"then
						if doExclude then
							NYX.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = card.ability.extra.multiplier,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									extra = true,
									card_limit = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Ramen" then
							NYX.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = card.ability.extra.multiplier,
								x_protect = true,
								unkeywords = {
									Xmult = true,
									card_limit = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Loyalty Card" then
							NYX.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = card.ability.extra.multiplier,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true,
									loyalty_remaining = true,
									every = true,
									card_limit = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Campfire" or G.jokers.cards[i].ability.name == "Hit the Road" then
							NYX.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = card.ability.extra.multiplier,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true,
									card_limit = true
								}
							})
						else
							NYX.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = card.ability.extra.multiplier,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true,
									size = true,
									chip_mod = true,
									h_size = true,
									increase = true,
									card_limit = true
								}
							})
						end
					end
				end	
				if context.blueprint then
					_card = context.blueprint_card
				end
				if _card and not _card.ability.eternal then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							SMODS.destroy_cards{ _card }
							return true
						end
					}))							
				end
			return{
				message = "fuck you nyx",
			}
			else
				return{
					message = "Nope"
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'astone',
    loc_txt = {
        name = 'Ascension Stone',
        text = {
          'After {C:attention}5{} rounds, becomes a {C:purple}Legendary{} Joker... {C:red,E:1}sometimes{}.',
		  "{C:inactive,s:0.8}(#1#/5){}",
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 5, y = 3},
	soul_pos = {x = 5, y = 1},
	config = {
		extra = {
			count = 0
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.count
			}
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			card.ability.extra.count = card.ability.extra.count + 1
			if card.ability.extra.count >= 5 and pseudorandom('nyx_acension',1,3) == 1 then
				play_sound('timpani', 0.5)
				if card.ability.extra.count > 10 then
					return {
						SMODS.destroy_cards{ card },
						SMODS.add_card {
							set = 'Joker',
							rarity = 'nyx_LostSoul',
							area = G.jokers
						},
						message = "01101110 01101001 01101100",
						colour = G.C.BLACK
					}
				else
					return {
						SMODS.destroy_cards{ card },
						SMODS.add_card {
							set = 'Joker',
							legendary = true,
							area = G.jokers
						},
						message = "Ascended!",
						colour = G.C.GOLD
					}
				end
			else
				return {
					message = "" .. card.ability.extra.count .. "/5",
					message_card = card,
					colour = G.C.PURPLE
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'Mathboy',
    loc_txt = {
        name = 'Mathematician',
        text = {
          '{C:attention}Copies{} all {E:2,C:dark_edition}Math{} Jokers',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 12, y = 3},
	calculate = function(self,card,context)
		local effects = {}
		for i=1, #G.jokers.cards do -- for all jokers
			if G.jokers.cards[i] ~= card then -- not itself
				local other_joker = G.jokers.cards[i]
				for i=1, #G.P_CENTER_POOLS["MathJokers"] do
					if (other_joker.config.center.key == (G.P_CENTER_POOLS["MathJokers"][i].key)) then
						local effect = SMODS.blueprint_effect(card, other_joker, context) -- get effect
						if effect then
							table.insert(effects, effect) -- add to array
						end
					end
				end
			end
		end
		return SMODS.merge_effects(effects) -- Do
	end
}
SMODS.Joker{
	key = 'sleep_schedule',
    loc_txt = {
        name = 'Sleep Schedule',
        text = {
          'This Joker gains {X:mult,C:white}X#1#{} Mult',
		  'per {C:attention}consecutive{} hand playing',
		  'your most played {C:red}hand{}',
		  '{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#2#{}{C:inactive,s:0.8} Mult){}',
		  "{C:inactive,s:0.8}What Nyx doesn't have{}",
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 15, y = 3},
	config = { 
		extra = {
			Xmult = 1,
			Xmult_gain = 0.1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult_gain,
				center.ability.extra.Xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.before and not context.blueprint then
            local reset = false
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for k, v in pairs(G.GAME.hands) do
				if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
					reset = true
				end
			end
            if reset then
                if card.ability.extra.Xmult > 1 then
                    card.ability.extra.Xmult = 1
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
	end
}
SMODS.Joker{
	key = 'fresh_start',
    loc_txt = {
        name = 'Fresh Start',
        text = {
          'All {C:attention}Odd{} cards',
		  'Give {X:mult,C:white}X#1#{} Mult when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 17, y = 3},
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_tragedy" then
				return false
            end
        end
        return true
    end,
	config = { 
		extra = {
			xmult = 1.5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0 and
                    context.other_card:get_id() % 2 == 1) or
                (context.other_card:get_id() == 14) then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
	end
}
SMODS.Joker{
	key = 'familiar_end',
    loc_txt = {
        name = 'Familiar End',
        text = {
          'All {C:attention}Even{} cards',
		  'Give {X:mult,C:white}X#1#{} Mult when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 18, y = 3},
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_tragedy" then
				return false
            end
        end
        return true
    end,
	config = { 
		extra = {
			xmult = 1.5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.ending_shop and not context.blueprint then
			local combine = true
			for _, joker in ipairs(G.jokers.cards or {}) do
				if joker.config.center.key == "j_nyx_lasting_adventure" then
					combine = false
				end
			end
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_fresh_start' and combine then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.destroy_cards { card, other_joker }
							return true
						end
					})) 
					SMODS.add_card{
						key = 'j_nyx_lasting_adventure'
					}
					return {
						message = "Combined!",
						colour = G.C.RED
					}
				end
			end
		end
		if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0 and
                    context.other_card:get_id() % 2 == 0) then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
	end
}
SMODS.Joker{
	key = 'lasting_adventure',
    loc_txt = {
        name = 'Lasting Adventure',
        text = {
          'All {C:attention}Non-face{} cards',
		  'Give {X:mult,C:white}X#1#{} Mult when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["MathJokers"] = true
	}, 
    atlas = 'Jokers',
    rarity = 4,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 19, y = 3},
	in_pool = function(self)
		return false 
	end,
	config = { 
		extra = {
			xmult = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
            if not context.other_card:is_face() then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
		if context.setting_blind and not context.blueprint then
			local origin = false
			local _end = false
			local odd_card = nil
			local even_card = nil
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_fresh_start' then
					origin = true
					odd_card = other_joker
				elseif other_joker.config.center.key == 'j_nyx_familiar_end' then
					_end = true
					even_card = other_joker
				end
				if origin and _end then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.destroy_cards { card, odd_card, even_card }
							return true
						end
					})) 
					SMODS.add_card{
						key = 'j_nyx_tragedy'
					}
					return {
						message = "Combined!",
						colour = G.C.RED
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'joe_supreme',
    loc_txt = {
        name = 'Joe Supreme',
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult for every {C:attention}Joe{}',
		  '{C:dark_edition,E:1,s:1.2}(Evolves into Joe Ultimate){}',
		  '{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 21, y = 3},
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_joe" or joker.config.center.key == "j_nyx_joe2" then
                return true
            end
        end
        return false
    end,
	config = { 
		extra = {
			xmult = 1,
			xmult_gain = 0.5
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe2
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.xmult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		local count = 0
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_joe" or joker.config.center.key == "j_nyx_joe2" 
			or joker.config.center.key == "j_nyx_joe_supreme" then
                count = count + 1
            end
        end
		card.ability.extra.xmult = 1 + (count * card.ability.extra.xmult_gain)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
		if context.after and not context.blueprint then
			if count >= 7 then
				for _, joker in ipairs(G.jokers.cards or {}) do
					if joker.config.center.key == "j_nyx_joe" or joker.config.center.key == "j_nyx_joe2" then
						local card_ = joker
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.destroy_cards{ card_ }
								return true
							end
						}))
					end
				end
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.destroy_cards{ card }
						SMODS.add_card {
							key = "j_nyx_joe_ultimate",
						}
						return true
					end
				}))
				return {
					message = 'Evolved!'
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'cupnball',
    loc_txt = {
        name = 'Cup & Ball',
        text = {
          '{X:mult,C:white}X#1#{} Mult but {C:attention}flips{} and',
		  '{C:attention}shuffles{} all Joker cards',
		  'every other hand'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 13, y = 4},
	config = { 
		extra = {
			xmult = 5,
			hand = false
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.hand
			}
		}
	end,
	calculate = function(self,card,context)
		if context.first_hand_drawn then
			card.ability.extra.hand = false
		end
		if card.ability.extra.hand == false then
			local eval = function() return card.ability.extra.hand and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
		end
		if context.joker_main then
			if card.ability.extra.hand == false then
				card.ability.extra.hand = true
				if #G.jokers.cards > 0 then
					G.jokers:unhighlight_all()
					for _, joker in ipairs(G.jokers.cards) do
						if joker ~= card then
							joker:flip()
						end
					end
					if #G.jokers.cards > 1 then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.2,
							func = function()
								G.E_MANAGER:add_event(Event({
									func = function()
										G.jokers:shuffle('aajk')
										play_sound('cardSlide1', 0.85)
										return true
									end,
								}))
								delay(0.15)
								G.E_MANAGER:add_event(Event({
									func = function()
										G.jokers:shuffle('aajk')
										play_sound('cardSlide1', 1.15)
										return true
									end
								}))
								delay(0.15)
								G.E_MANAGER:add_event(Event({
									func = function()
										G.jokers:shuffle('aajk')
										play_sound('cardSlide1', 1)
										return true
									end
								}))
								delay(0.5)
								return true
							end
						}))
					end
				end
			else
				card.ability.extra.hand = false
			end
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'ouroboros',
    loc_txt = {
        name = 'Ouroboros',
        text = {
          'Always draw {C:attention}#1# cards{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 19, y = 4},
	config = { 
		extra = {
			cards = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.cards
			}
		}
	end,
	calculate = function(self,card,context)
		if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
			return {
				cards_to_draw = card.ability.extra.cards
			}
		end
	end
}
SMODS.Joker{
	key = 'malware',
    loc_txt = {
        name = 'Malware',
        text = {
          '{C:attention,E:2}Randomly{} convert',
		  'a Joker into {C:red}Malware{}',
		  'Gains {X:chips,C:white}X#2#{} Chips per {C:red}Malware{}',
		  '{C:inactive}Becomes {}{C:dark_edition}Negative{}{C:inactive} after #3# rounds{}',
		  '{C:inactive,s:0.8}(Currently {}{X:chips,C:white,s:0.8}X#1#{} Chips){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 20, y = 4},
	config = { 
		extra = {
			Xchip = 1,
			Xchip_gain = 0.5,
			rounds = 10
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return{
			vars = {
				center.ability.extra.Xchip,
				center.ability.extra.Xchip_gain,
				center.ability.extra.rounds
			}
		}
	end,
	calculate = function(self,card,context)
		local chose = false
		local ran = pseudorandom('malware',1,5000)
		if ran == 777 then
			chose = true
		end
		if context.joker_main then
			card.ability.extra.Xchip = 1
			for i=1, #SMODS.find_card("j_nyx_malware")-1 do
				card.ability.extra.Xchip = card.ability.extra.Xchip + card.ability.extra.Xchip_gain
			end
			return {
				xchips = card.ability.extra.Xchip,
				card = card
			}
		end
		if (context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint) and card.ability.extra.rounds > 0 then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds == 0 then
                card:set_edition({ negative = true })
            end
        end
		if chose then
			local malware_candidates = {}
			for i=1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker ~= card and other_joker.config.center.key ~= 'j_nyx_malware' and other_joker.config.center.key ~= 'j_nyx_err' then
					table.insert(malware_candidates, other_joker)
				end
			end
			if #malware_candidates > 0 then
				local chosen = malware_candidates[math.random(1, #malware_candidates)]
				G.E_MANAGER:add_event(Event({
					func = function()
						G.jokers:remove_card(chosen)
						chosen:remove()
						chosen = nil
						SMODS.add_card {
							key = "j_nyx_malware",
							area = G.jokers
						}
						return true
					end
				}))
				return {
					message = "Infected!",
					colour = G.C.RED
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'rotated',
    loc_txt = {
        name = 'Rotated Joker',
        text = {
          'Swaps {C:chips}Chips{} and',
		  '{C:mult}Mult{} before scoring'
		  }
	},
	pools = {
		["ModJonklers"] = true,
		["Horizonjokers"] = true
	},
	display_size = {w = 112, h = 112},
    atlas = 'RotatedJokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
	calculate = function(self,card,context)
		if context.initial_scoring_step then
			return {
				swap = true,
				message = "Rotated!",
				message_card = card,
				colour = G.C.GREEN
			}
		end
	end
}
-- Legendary --
SMODS.Joker{
	key = 'plaguebearer',
    loc_txt = {
        name = 'Plague Bearer',
        text = {
          'All {C:attention}Diseased{} cards give {X:mult,C:white}X#1#{}',
		  '{C:attention}Evolves{} when all cards are {C:attention}Diseased{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true
	}, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
    atlas = 'Jokers',
    rarity = 4,
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 18, y = 2},
	config = { 
		extra = {
			xMult = 1.5
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_nyx_diseased
		return{
			vars = {
				center.ability.extra.xMult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_nyx_diseased') then
				return {
					Xmult = card.ability.extra.xMult,
					card = card
				}
			end
		end
		if context.after and not context.blueprint then
			local count = 0
			for i=1, #G.playing_cards do
				if SMODS.has_enhancement(G.playing_cards[i], 'm_nyx_diseased') then
					count = count + 1
				end
			end
			if count == #G.playing_cards then
				G.E_MANAGER:add_event(Event({
					func = function()
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								SMODS.add_card {
									key = "j_nyx_pestilence"
								}
							return true; end})) 
						return true
					end
				})) 
				return {
					message = "Evolved!",
					colour = G.C.GREEN,
				}
			end
		end
	end
}
SMODS.Joker{
    key = 'sybyrr', --joker key
    loc_txt = { -- local text
        name = 'Sybyrrrrrr',
        text = {
          'Gains {X:mult,C:white}X#1#{} Mult for every {C:attention}$1{} you have',
		  'All {C:attention}Jokers{} give {C:attention}#2#${}',
		  '{C:inactive,s:0.8}(Currently{} {X:mult,C:white,s:0.8}X#3#{} Mult){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["DPGJokers"] = true,
		["FoodJokers"] = true
	},
    atlas = 'Jokers', --atlas' key
    rarity = 4, --rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    soul_pos = { x = 0, y = 1 },
    cost = 10, --cost
    unlocked = true, --where it is unlocked or not: if true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable
    pos = {x = 1, y = 0}, --position in atlas, starts at 0, scales by the atlas' card size (px and py): {x = 1, y = 0} would mean the sprite is 71 pixels to the right
	config = { 
		extra = {
			xMult_gain = 0.05,
			money = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xMult_gain,
				center.ability.extra.money,
				1+(center.ability.extra.xMult_gain * math.max(0, (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)))
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
            return {
				Xmult = 1+(card.ability.extra.xMult_gain * math.max(0, (G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)))
			}
		end
		if context.other_joker then
			return {
				dollars = card.ability.extra.money,
				card = context.other_context and context.other_context.blueprint_card or context.other_card or nil,
			}
		end
	end
}
SMODS.Joker{
    key = 'pyro',
    loc_txt = {
        name = 'Owner of DPG.tf',
        text = {
          'What more did you expect?'
        },
    },
	pools = {
		["ModJonklers"] = true,
		["DPGJokers"] = true
	},
    atlas = 'Jokers',
    rarity = 4,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 10, y = 0},
	calculate = function(self,card,context)
		if context.setting_blind then
			if math.random(0,3) <= 2 then
				return {
					message = 'Server Crash!',
					message_card = card,
					G.jokers:remove_card(card),
					card:remove(),
					card = nil,
					SMODS.add_card {
						key = 'c_soul'
					}
				}
			else
				return {
					message = 'Server Crash!',
					message_card = card,
					G.jokers:remove_card(card),
					card:remove(),
					card = nil,
					SMODS.add_card {
						key = 'c_nyx_lostsoul'
					}
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'joe_ultimate',
    loc_txt = {
        name = 'Joe Ultimate',
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult for every {C:attention}Joe{}',
		  '{C:attention}Joe\'s{} no longer reduce {C:chips}Chips{}',
		  '{C:dark_edition,E:1,s:1.2}(Evolves into Joe Almighty){}',
		  '{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 4,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 1, y = 4},
	in_pool = function(self, args)
        return false
    end,
	config = { 
		extra = {
			xmult = 1,
			xmult_gain = 1.5
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe2
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.xmult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		local count = 0
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_joe" or joker.config.center.key == "j_nyx_joe2" or 
			joker.config.center.key == "j_nyx_joe_supreme" then
                count = count + 1
            end
        end
		card.ability.extra.xmult = 1 + (count * card.ability.extra.xmult_gain)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
		if context.after and not context.blueprint then
			if count >= 12 then
				for _, joker in ipairs(G.jokers.cards or {}) do
					if joker.config.center.key == "j_nyx_joe" or joker.config.center.key == "j_nyx_joe2" 
					or joker.config.center.key == "j_nyx_joe_supreme" then
						local card_ = joker
						G.E_MANAGER:add_event(Event({
							func = function()
								card_.T.r = -0.2
								card_:juice_up(0.3, 0.4)
								card_.states.drag.is = true
								card_.children.center.pinch.x = true
								G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
									func = function()
										G.jokers:remove_card(card_)
										card_:remove()
										card_ = nil
									return true; end})) 
								return true
							end
						}))
					end
				end
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.destroy_cards{ card }
						SMODS.add_card {
							key = "j_nyx_joe_almighty",
						}
						return true
					end
				}))
				return {
					message = 'Evolved!'
				}
			end
		end
	end
}
SMODS.Joker{
	key = 'entropy',
    loc_txt = {
        name = 'Entropy',
        text = {
          'Converges all {C:attention}scored cards{}',
		  'Towards the {C:attention}last{} card'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = 4,
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 14, y = 4},
	calculate = function(self,card,context)
		if context.before and context.main_eval and not context.blueprint then
			local last_card = context.scoring_hand[#context.scoring_hand]
			local con = tonumber(last_card:get_id())
			for i=1, #context.scoring_hand do
				if context.scoring_hand[i] ~= context.scoring_hand[#context.scoring_hand] then
					local _card = context.scoring_hand[i]
					if tonumber(_card:get_id()) > con then
						SMODS.modify_rank(_card, -1)
						_card:juice_up(0.3, 0.4)
						play_sound('card1')
					elseif tonumber(_card:get_id()) < con then
						SMODS.modify_rank(_card, 1)
						_card:juice_up(0.3, 0.4)
						play_sound('card1')
					end
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'gourmet',
    loc_txt = {
        name = 'The Gourmet',
        text = {
          '{C:attention}Copies{} all {E:2,C:attention}Food{} Jokers',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = 4,
    cost = 15,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	soul_pos = {x = 2, y = 1},
    pos = {x = 0, y = 4},
	calculate = function(self,card,context)
		local effects = {}
		for i=1, #G.jokers.cards do -- for all jokers
			if G.jokers.cards[i] ~= card then -- not itself
				local other_joker = G.jokers.cards[i]
				for i=1, #G.P_CENTER_POOLS["FoodJokers"] do
					if (other_joker.config.center.key == (G.P_CENTER_POOLS["FoodJokers"][i].key)) or other_joker.ability.nyx_edible then
						local effect = SMODS.blueprint_effect(card, other_joker, context) -- get effect
						if effect then
							table.insert(effects, effect) -- add to array
						end
					end
				end
			end
		end
		return SMODS.merge_effects(effects)
	end
}
-- LOST SOULS --
SMODS.Joker{
	key = 'fate',
    loc_txt = {
        name = 'FATE',
        text = {
        	'Copies the effects of all other Jokers',
			'{C:inactive,s:0.8}Does not copy {}{C:attention,s:0.8}Blueprint, Brainstorm, {}{C:inactive,s:0.8}or{} {C:attention,s:0.8}FATE{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: bozo!', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true
	},
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    soul_pos = {x = 3, y = 1},
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 2},
	calculate = function(self, card, context)
		local effects = {}
		for i=1, #G.jokers.cards do -- for all jokers
			if G.jokers.cards[i] ~= card then -- not itself
				local other_joker = G.jokers.cards[i]
				
				if ((other_joker.config.center.key ~= "j_blueprint" and other_joker.config.center.key ~= "j_brainstorm") or horizonmod.config.enable_FATE2) and other_joker.config.center.key ~= "j_nyx_fate" then
					local effect = SMODS.blueprint_effect(card, other_joker, context) -- get effect
					if effect then
						table.insert(effects, effect) -- add to array
					end
				end
			end
		end
		return SMODS.merge_effects(effects) -- Do
		
		-- blueprint code
		-- local other_joker
		-- for i=1, #G.jokers.cards do
		-- 	if G.jokers.cards[i] == card and G.jokers.cards[i+1] then
		-- 		other_joker = G.jokers.cards[i+1]
		-- 	end
		-- end
		-- local effects = {}
		-- local effect = SMODS.blueprint_effect(card, other_joker, context)
		-- if effect then
		-- 	table.insert(effects, effect)
		-- end
		-- return SMODS.merge_effects(effects)
    end
}
SMODS.Joker{
	key = 'pestilence',
    loc_txt = {
        name = '{C:green,E:2,s:1.2}Pestilence{}',
        text = {
          'Scored {C:attention}Diseased{} cards give {X:mult,C:white}X#1#{} Mult',
		  'All {C:attention}Diseased{} cards {C:attention}retrigger #2#{} time',
		  '{C:attention}Diseased{} cards no longer {C:red}decay{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true
	},
	in_pool = function(self)
		return false 
	end,
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 19, y = 2},
	soul_pos = {x = 19, y = 1},
	config = { 
		extra = {
			xMult = 2.5,
			repetitions = 1,
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_nyx_diseased
		return{
			vars = {
				center.ability.extra.xMult,
				center.ability.extra.repetitions
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_nyx_diseased') then
				return {
					Xmult = card.ability.extra.xMult,
					card = card
				}
			end
		end
		if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_nyx_diseased') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
	end
}
local jimboLines = {
	"You Aced it!",
	"You dealt with that pretty well!",
	"Looks like you weren't bluffing!",
	"Too bad these chips are all virtual...",
	"How the turn tables.",
	"Looks like I've taught you well!",
	"You made some heads up plays!",
	"Good thing I didn't bet against you!",
	"Maybe Go Fish is more our speed...",
	"We folded like a cheap suit!",
	"Time for us to shuffle off and try again!",
	"You know what they say, the house always wins!",
	"Looks like we found out who the real Joker is!",
	"Oh no, were you bluffing too?",
	"Looks like the joke's on us!",
	"If I had hands I would have covered my eyes!",
	"I'm literally a fool, what's your excuse?",
	"What a flop!"
}
local jimboVoice = {
	"voice1",
	"voice2",
	"voice3",
	"voice4",
	"voice5",
	"voice6",
	"voice7",
	"voice8",
	"voice9",
	"voice10",
	"voice11"
}
SMODS.Joker{
	key = 'stairway',
    loc_txt = {
        name = 'Stairway of Jimbo',
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult for every card {C:attention}scored{}',
		  '{C:attention}Resets{} at the end of round',
		  '{C:inactive,s:0.8}Currently{} {X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true
	},
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 21, y = 2},
	soul_pos = {x = 21, y = 1},
	config = { 
		extra = {
			xMult = 1.05,
			xMult_gain = 0.05,
			xMult_base = 1.05
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xMult,
				center.ability.extra.xMult_gain,
				center.ability.extra.xMult_base
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			local xMult = card.ability.extra.xMult
			-- Upgrade the xMult if not blueprint
			if not context.blueprint then
				card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMult_gain
			end
			return {
				Xmult = xMult,
				card = card
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.xMult = card.ability.extra.xMult_base
			G.E_MANAGER:add_event(Event({
				func = function()
					local voice = jimboVoice[math.random(1, #jimboVoice)]
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.5,
						blockable = false,
						func = function()
							card:juice_up(0.1, 0.2)
							play_sound(voice)
							return true
						end
					}))
					return true
				end
			}))
			return {
				message = jimboLines[math.random(1, #jimboLines)],
				message_card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'nerd',
    loc_txt = {
        name = 'Nerd',
        text = {
          'All {C:attention}8s{} {C:attention}retrigger #1#{} times',
		  "All {C:attention}scoring{} cards that aren't {C:attention}8s{} are {C:red}destroyed{}",
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["MathJokers"] = true
	},
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 8, y = 2},
	in_pool = function(self, args)
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_penis" then
				return false
            end
        end
        return true
    end,
	config = { 
		extra = {
			retrigger = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.retrigger
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 8 then
				return {
					repetitions = card.ability.extra.retrigger,
					card = card
				}
			end
		end
		if context.destroy_card and not context.blueprint then
			for i = 1, #context.scoring_hand do
				if context.destroy_card == context.scoring_hand[i] and context.scoring_hand[i]:get_id() ~= 8 then
					return {
						remove = true
					}
				end
			end
		end
		if context.ending_shop and not context.blueprint then
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_moist' then
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.destroy_cards{ card , other_joker }
							return true
						end
					})) 
					SMODS.add_card{
						key = 'j_nyx_penis'
					}
					return {
						message = "Combined!",
						colour = G.C.RED
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = '@everyone',
    loc_txt = {
        name = '{X:chips,C:white}@everyone{}',
        text = {
          '{C:inactive,s:1.2,E:2}[11:43 PM]{} {C:green,s:1.2,E:2}Juic+e [131/150]{}{C:inactive,s:1.2,E:2}:{} {s:1.2,E:2}Oops{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    cost = 15,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 20, y = 3},
	config = { 
		extra = {
			mult = 161156
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				mult = center.ability.extra.mult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
		if context.starting_shop and not card.ability.eternal then
			G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards{ card }
					return true
				end
            })) 
		end
	end
}
SMODS.Joker{
	key = 'JAH',
    loc_txt = {
        name = 'Jokers Against Humanity',
        text = {
          'Creates a {V:1}Card{}',
		  'At the start of each round',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 14, y = 2},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				colours = { HEX('808080') }
			}
		}
	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			return {
				message = 'Card Drawn!',
				message_card = card,
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card({set = "Joker", rarity = 'nyx_Misc', stickers = {"eternal"}})
						return true
					end
				}))
			}
		end
	end
}
SMODS.Joker{
	key = 'joe_almighty',
    loc_txt = {
        name = 'Joe Almighty',
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult',
		  'And {X:chips,C:white}X#4#{} Chips',
		  'for every {C:attention}Joe{}',
		  '{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult){}',
		  '{C:inactive,s:0.8}(Currently {}{X:chips,C:white,s:0.8}X#3#{} {C:inactive,s:0.8}Chips){}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 4},
	in_pool = function(self, args)
        return false
    end,
	config = { 
		extra = {
			xmult = 1,
			xmult_gain = 2.5,
			xchips = 1,
			xchips_gain = 1.5
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe2
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.xmult_gain,
				center.ability.extra.xchips,
				center.ability.extra.xchips_gain
			}
		}
	end,
	calculate = function(self,card,context)
		local count = 0
        for _, joker in ipairs(G.jokers.cards or {}) do
            if joker.config.center.key == "j_nyx_joe" or joker.config.center.key == "j_nyx_joe2" 
			or joker.config.center.key == "j_nyx_joe_supreme" or joker.config.center.key == "j_nyx_joe_ultimate" then
                count = count + 1
            end
        end
		card.ability.extra.xmult = 1 + (count * card.ability.extra.xmult_gain)
		card.ability.extra.xchips = 1 + (count * card.ability.extra.xchips_gain)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
				xchips = card.ability.extra.xchips,
				card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'tragedy',
    loc_txt = {
        name = 'A True Tragedy',
        text = {
          'All {C:attention}Non-face{} cards',
		  'Give {X:mult,C:white}X#1#{} Mult when scored',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	pools = {
		["ModJonklers"] = true,
		["MathJokers"] = true
	},
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 20,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 4},
	in_pool = function(self)
		return false 
	end,
	config = { 
		extra = {
			xmult = 5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
            if not context.other_card:is_face() then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
	end
}
if horizonmod.config.enable_Malware then
SMODS.Joker{
	key = 'spacewar',
    loc_txt = {
        name = 'spacewar.exe',
        text = {
          '{C:attention}Installs{} spacewar',
		  'And {C:attention}runs{} it'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('MALWARE', G.C.BLACK, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 10, y = 4},
	set_ability = function(self, card, initial)
		card:set_eternal(true)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			if math.random(1,100) == 1 then
				os.execute('start https://www.youtube.com/watch?v=dQw4w9WgXcQ')
			else
				os.execute('start steam://run/480')
			end
		end
	end
}
SMODS.Joker{
	key = 'loss',
    loc_txt = {
        name = 'Loss',
        text = {
          'There is nothing to be done',
		  'Just accept it',
		  '{C:inactive,s:0.8}(No seriously just restart the run){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('MALWARE', G.C.BLACK, G.C.WHITE, 0.8 )
	end,
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 9, y = 4},
	set_ability = function(self, card, initial)
		card:set_eternal(true)
	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			os.exit()
		end
	end
}
end
SMODS.Joker {
	key = 'aceofitself',
	loc_txt = {
		name = 'Ace of Itself',
		text = {
			'All aces {C:attention}retrigger{} an additional time',
			'for each {C:attention}scoring ace{}',
		},
	},
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 22, y = 4},
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == 14 then
				local count = 0
				for i = 1, #context.scoring_hand do
					if context.scoring_hand[i]:get_id() == 14 then
						count = count + 1
					end
				end
				return {
					repetitions = count,
					card = card
				}
			end
		end
	end
}
-- MISC SHIT --
SMODS.Atlas{
    key = 'Cards', --atlas key
    path = 'Cards.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
--CARDS--
SMODS.Joker{
	key = 'card_Balatro',
    loc_txt = {
        name = 'Balatro',
        text = {
          'Does nothing',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 0},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Bad',
    loc_txt = {
        name = 'Bad',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 1, y = 0},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			xmult = 0.5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Alright',
    loc_txt = {
        name = 'Alright',
        text = {
          '{C:chips}+#1#{} Chips',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			chips = 50
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.chips
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_FA',
    loc_txt = {
        name = 'Fucking Awesome',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 0},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			xmult = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Stupid',
    loc_txt = {
        name = 'Stupid',
        text = {
          'Calls you a mean name',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			local names = {'Stupid','Moron','Nerd','Asshole','Retard','Fuck Face',
						  'Shithead','Motherfucker','Dick','Dickwad','Dickhead','Cunt',
						  'Joe','Sogger','Logger','Ourpler','Liptard','Eurotard'}
			return {
				message = 'You are a '..names[math.random(1, #names)],
				message_card = card
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Rich',
    loc_txt = {
        name = 'Rich',
        text = {
          '{C:money}$#1#{}',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 0},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			money = 10
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				dollars = card.ability.extra.money
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Cheap',
    loc_txt = {
        name = 'Cheap',
        text = {
          '{C:money}$#1#{}',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 1},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			money = -5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				dollars = card.ability.extra.money
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_notfun',
    loc_txt = {
        name = 'Not Fun',
        text = {
          '{C:red}Disables{} a random {C:attention}Joker{}',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 0, y = 1},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	add_to_deck = function(self, card, from_debuff)
        local index = math.random(1,#G.jokers.cards)

		-- Debuff joker
		local jokerToDebuff = G.jokers.cards[index]

		-- You cannot beat ERROR.
		if jokerToDebuff.config.center.key ~= 'j_nyx_err' then
			SMODS.debuff_card(jokerToDebuff, true, "notfun")
		end
    end,
	remove_from_deck = function(self, card, from_debuff)
		for i = 1, #G.jokers.cards do
			local joker = G.jokers.cards[i]
			local canUndebuff = true

			-- Check if joker is chosen by crimson heart or has perished
			if joker.ability.perishable then
				if joker.ability.perish_tally <= 0 then
					canUndebuff = false
				end
			end

			if joker.ability.crimson_heart_chosen then
				canUndebuff = false
			end

			if canUndebuff then
				SMODS.debuff_card(joker, false, "notfun")
			end
		end
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Moist',
    loc_txt = {
        name = 'Moist',
        text = {
          '{C:attention}Summons{} {C:blue}Moist{}',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 1, y = 1},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_moist
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.add_card {
			key = 'j_nyx_moist'
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Milky',
    loc_txt = {
        name = 'Milky',
        text = {
          '{C:attention}Summons{} the {C:blue}Milk Mann{}',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 1},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_milkmann
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.add_card {
			key = 'j_nyx_milkmann'
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Joement',
    loc_txt = {
        name = 'A Joement',
        text = {
          '{C:attention}Summons{} 3 {C:blue}Joe{}s',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 1},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_joe
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3,
			func = function()
				local temp = nil
				temp = SMODS.add_card {
					key = 'j_nyx_joe',
					stickers = {"eternal"},
				}
				temp:add_sticker("eternal",true)
				temp = SMODS.add_card {
					key = 'j_nyx_joe',
					stickers = {"eternal"},
				}
				temp:add_sticker("eternal",true)
				temp = SMODS.add_card {
					key = 'j_nyx_joe',
					stickers = {"eternal"},
				}
				temp:add_sticker("eternal",true)
				return true
			end,
		}))
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'card_Nerdy',
    loc_txt = {
        name = 'White and Nerdy',
        text = {
          '{C:attention}Summons{} a {C:blue}Nerd{}',
		  '{C:red}Self destructs after 1 round{}',
		  }
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    atlas = 'Cards',
    rarity = "nyx_Misc",
    cost = 0,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 1},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_eternal(true)
	end,
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_nerd
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.add_card {
			key = 'j_nyx_nerd'
		}
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.Stickers.eternal:apply(card, false)
					SMODS.destroy_cards{ card }
					return true
				end
			}))
		end
	end
}
--
--[[
SMODS.Joker{
	key = '',
    loc_txt = {
        name = '',
        text = {
          ''
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 1,
    cost = 0,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
	config = { 
		extra = {
			
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				
			}
		}
	end,
	calculate = function(self,card,context)
		if  then
		
		end
	end
}
]]
--

-- unfinished jokers below--
-- unfinished jokers below--
-- unfinished jokers below--
if horizonmod.config.enable_WIP_cards then
-- Common --
SMODS.Joker{
	key = 'shoppingmall',
    loc_txt = {
        name = 'Shopping Mall',
        text = {
          '{C:attention}+#1#{} card slot available in shop',
		  '{C:attention}-#1#{} consumable slot'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
	config = { 
		extra = {
			slots = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.slots
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
		func = function()
			change_shop_size(card.ability.extra.slots)
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
			return true
		end
		}))
  	end,
  	remove_from_deck = function(self, card, from_debuff)
   		G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
		G.GAME.shop.joker_max = G.GAME.shop.joker_max - card.ability.extra.slots
  	end
}
SMODS.Joker{
	key = 'guillotine',
    loc_txt = {
        name = 'Guillotine',
        text = {
        	'When discarding {C:attention}Face{} cards',
			'{C:green}#2# in #1#{} chance to {C:red}Behead{} it instead',
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
	config = {
		extra = {
			odds = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	calculate = function(self,card,context)
		if context.discard and not context.blueprint then
			if  (context.other_card:get_id() == 11 or
				context.other_card:get_id() == 12 or
				context.other_card:get_id() == 13) then
				if pseudorandom('guillotine') < G.GAME.probabilities.normal / card.ability.extra.odds then
					local beheadedcard = context.other_card
					local suit = beheadedcard.base.suit
					if context.other_card:get_id() == 13 then
						local ran = math.random(3, 10)
						local card1 = SMODS.add_card({set = 'Base', area = G.deck})
						local card2 = SMODS.add_card({set = 'Base', area = G.deck})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.1,
							func = function()
								copy_card(beheadedcard, card1)
								SMODS.change_base(card1, suit, ""..ran.."")
								copy_card(beheadedcard, card2)
								SMODS.change_base(card2, suit, ""..(context.other_card:get_id()-ran).."")
								SMODS.destroy_cards{ beheadedcard }
								return true
							end
						}))
					else
						local ran = math.random(2, 10)
						local card1 = SMODS.add_card({set = 'Base', area = G.deck})
						local card2 = SMODS.add_card({set = 'Base', area = G.deck})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.1,
							func = function()
								copy_card(beheadedcard, card1)
								SMODS.change_base(card1, suit, ""..ran.."")
								copy_card(beheadedcard, card2)
								SMODS.change_base(card2, suit, ""..(context.other_card:get_id()-ran).."")
								SMODS.destroy_cards{ beheadedcard }
								return true
							end
						}))
					end
					return {
						message = "Beheaded!",
						message_card = card
					}
				end
			end
		end
	end
}
SMODS.Joker{
	key = 'bagofchips',
    loc_txt = {
        name = 'Bag of Chips',
        text = {
          'When {C:attention}selling{} a card gain {C:red}X#2#{}',
		  'Its {C:money}sell value{} as {C:chips}Chips{}',
		  '{C:inactive,s:0.8}(Currently {C:chips,s:0.8}#1#{}{C:inactive,s:0.8} Chips){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
	config = { 
		extra = {
			chips = 0,
			mult = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.chips,
				center.ability.extra.mult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
		if context.selling_card then
			card.ability.extra.chips = (context.card.sell_cost*2) + card.ability.extra.chips
		end
	end
}
-- Uncommon --
if horizonmod.config.enable_AllIn then
SMODS.Joker{
	key = 'allinred',
    loc_txt = {
        name = '{C:red,E:1}All In{}',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  'Generates random perishable {C:attention}Jokers{}',
		  'Never see a {C:attention}shop{} again'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Placeholder',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 3, y = 0},
	set_ability = function(self, card, initial)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			Xmult = 8,
			count = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.count
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			if #G.jokers.cards < G.jokers.config.card_limit then
				local temp = nil
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						play_sound('timpani')
						temp = SMODS.add_card({ set = 'Joker' })
						temp:add_sticker("perishable",true)
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
			card.ability.extra.count = 1
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
			}
		end
		if G.shop and card.ability.extra.count == 1 then
			card.ability.extra.count = card.ability.extra.count + 1
			for i = 1, #G.jokers.cards do
				G.jokers.cards[i]:calculate_joker({ending_shop = true})
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 1,
				func = function()
					G.shop.alignment.offset.y = G.ROOM.T.y + 29
					G.SHOP_SIGN.alignment.offset.y = -15
				return true
				end
			})) 
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 1.5,
				func = function()
					G.shop:remove()
					G.shop = nil
					G.SHOP_SIGN:remove()
					G.SHOP_SIGN = nil
					G.STATE_COMPLETE = false
					G.STATE = G.STATES.BLIND_SELECT
					G.CONTROLLER.locks.toggle_shop = nil
					return true
				end
			}))
		end
	end
}
SMODS.Joker{
	key = 'allinblack',
    loc_txt = {
        name = '{C:black,E:1}All In{}',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  '{C:blue}+3{} Hands and Discards',
		  'Hand {C:attention}size{} is set to 1'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Placeholder',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 3, y = 0},
	set_ability = function(self, card, initial)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			Xmult = 6, -- Logger
			hand_size = 1,
			hands = 3
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.hand_size,
				center.ability.extra.hands
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.hand_size = G.hand.config.card_limit
		G.hand:change_size(-card.ability.extra.hand_size + 1)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.hand_size - 1)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
			}
		end
		if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
					ease_discard(card.ability.extra.hands)
                    ease_hands_played(card.ability.extra.hands)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                        context.blueprint_card or card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
	end
}
SMODS.Joker{
	key = 'allingreen',
    loc_txt = {
        name = '{C:green,E:1}All In{}',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  'Ante scaling is halved',
		  'Joker {C:attention}slots{} are set to 1'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Placeholder',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 3, y = 0},
	set_ability = function(self, card, initial)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			Xmult = 10,
			joker_slots = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.joker_slots
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.joker_slots = G.jokers.config.card_limit
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots + 1
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1)/2
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots - 1
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1)*2
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
			}
		end
	end
}
SMODS.Joker{
	key = 'allin',
    loc_txt = {
        name = '{C:edition,s:1.2,E:2}All in{}',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  'Contains all the previous effects',
		  '{C:red}There is no shop{}',
		  '{C:red}Only one card{}',
		  '{C:red}Only one Joker{}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {["Horizonjokers"] = true},
    atlas = 'Placeholder',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 3, y = 0},
	set_ability = function(self, card, initial)
		card:set_eternal(true)
	end,
	config = { 
		extra = {
			Xmult = 30,
			hand_size = 1,
			joker_slots = 1,
			discards = 5,
			count = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.hand_size,
				center.ability.extra.joker_slots,
				center.ability.extra.discards,
				center.ability.extra.count
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1)/2
		card.ability.extra.hand_size = G.hand.config.card_limit
		G.hand:change_size(-card.ability.extra.hand_size + 1)
		card.ability.extra.joker_slots = G.jokers.config.card_limit
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots + 1
		local deletable_jokers = {}
		local hasError = false
		for k, v in pairs(G.jokers.cards) do
			deletable_jokers[#deletable_jokers + 1] = v

			-- Check if the joker is an ERROR
			if v.config.center.key == 'j_nyx_err' then
				hasError = true
			end
		end
		local _first_dissolve = nil
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = function()
				if not hasError then
					for k, v in pairs(deletable_jokers) do
						v:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
				end
				return true
			end,
		}))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1)*2
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots - 1
		G.hand:change_size(card.ability.extra.hand_size - 1)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			local temp = nil
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('timpani')
					temp = SMODS.add_card({ set = 'Joker', edition = 'e_negative' })
					temp:set_edition('e_negative',true)
					temp:add_sticker("perishable",true)
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			card.ability.extra.count = 1
			return {
				Xmult = card.ability.extra.Xmult,
				card = card
			}
		end
		if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
					ease_discard(card.ability.extra.discards)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_discards', vars = { card.ability.extra.discards } } },
                        context.blueprint_card or card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
		if G.shop and card.ability.extra.count == 1 then
			card.ability.extra.count = card.ability.extra.count + 1
			for i = 1, #G.jokers.cards do
				G.jokers.cards[i]:calculate_joker({ending_shop = true})
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 1,
				func = function()
					G.shop.alignment.offset.y = G.ROOM.T.y + 29
					G.SHOP_SIGN.alignment.offset.y = -15
				return true
				end
			})) 
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 1.5,
				func = function()
					G.shop:remove()
					G.shop = nil
					G.SHOP_SIGN:remove()
					G.SHOP_SIGN = nil
					G.STATE_COMPLETE = false
					G.STATE = G.STATES.BLIND_SELECT
					G.CONTROLLER.locks.toggle_shop = nil
					return true
				end
			}))
		end
	end
}
end

-- Rare --
SMODS.Joker{
	key = 'p2w',
    loc_txt = {
        name = '{C:money}Pay-2-Win{}',
        text = {
          'Gains {X:mult,C:white}X#3#{} Mult every {C:attention}Ante{}',
		  'But every time this joker {C:attention}triggers{}',
		  'You lose {C:red}$#2#{} {C:inactive}(Increases every ante){}',
		  '{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 3,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0},
	config = { 
		extra = {
			mult = 1.5,
			money = 2,
			mult_gain = 1.5,
			money_gain = 2,
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.mult,
				center.ability.extra.money,
				center.ability.extra.mult_gain,
				center.ability.extra.money_gain
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.mult,
				dollars = -card.ability.extra.money,
				card = card
			}
		end
		if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_gain
        end
	end
}
SMODS.Joker{
	key = 'sleightofhand',
    loc_txt = {
        name = 'Sleight of Hand',
        text = {
          'Gives {X:mult,C:white}X#1#{} Mult but has a',
		  '{C:green}#3# in #2#{} chance to flip cards in hand'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0},
	config = { 
		extra = {
			xmult = 3,
			odds = 7
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
		if context.stay_flipped and context.to_area == G.hand and
			SMODS.pseudorandom_probability(blind, 'nyx_soh', 1, 7) then
			return {
				stay_flipped = true
			}
		end
	end
}
SMODS.Joker{
	key = 'shootingstar',
    loc_txt = {
        name = 'Shooting Star',
        text = {
        	'All {C:attention}Star-Crossed{} cards',
			'{C:attention}Increment{} when scored'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
	in_pool = function(self)
		for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_nyx_starcrossed') then
                return true
            end
        end
        return false
	end,
    atlas = 'Placeholder',
    rarity = 3,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_nyx_starcrossed']
    end,
}
SMODS.Joker{
	key = 'astrophysics',
    loc_txt = {
        name = 'Astrophysics',
        text = {
        	'All {C:attention}Star-Crossed{} cards',
			'{C:attention}Scale{} faster when scored'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
	in_pool = function(self)
		for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_nyx_starcrossed') then
                return true
            end
        end
        return false
	end,
    atlas = 'Placeholder',
    rarity = 3,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_nyx_starcrossed']
    end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			if SMODS.has_enhancement(context.other_card, 'm_nyx_starcrossed') then
				context.other_card.ability.extra.mult_gain = context.other_card.ability.extra.mult_gain + 0.01
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.MULT
				}
			end
		end
	end
}
-- Legendary --
SMODS.Joker{
	key = 'loadeddice',
    loc_txt = {
        name = 'Loaded Dice',
        text = {
          'All {C:attention}probabilities{} are {C:green}Guaranteed{}',
		  '{C:inactive,s:0.8}(Hopefully){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
    atlas = 'Placeholder',
    rarity = 4,
    cost = 12,
    unlocked = true,
    discovered = false,
	no_collection = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 0},
	in_pool = function(self)
		return false 
	end,
	add_to_deck = function(self, card, from_debuff)
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = v*1000
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = v/1000
		end
	end,
}
SMODS.Joker{
	key = 'longroad',
    loc_txt = {
        name = 'The Long Road',
        text = {
          'If playing the {C:attention}final hand{}',
		  'and have {C:red}<10%{} of {C:attention}Blind Requirements{}',
		  '{C:attention}Retrigger{} {C:red}ALL{} Cards',
		  '{C:inactive,s:0.8}(Played and in Hand){}'
        },
    },
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
    atlas = 'Placeholder',
    rarity = 4,
    cost = 12,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 0},
	config = { 
		extra = {
			repetitions = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.repetitions
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and (context.cardarea == G.play or context.cardarea == G.hand) and G.GAME.current_round.hands_left == 0 and (G.GAME.chips < (G.GAME.blind.chips/10)) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
	end
}
-- LOST SOULS --
--
end
--- Other Stuff ---
-- Angelic --
SMODS.ConsumableType {
    key = 'nyx_angelic',
    collection_rows = { 4, 5 },
    primary_colour = HEX('000000'),
    secondary_colour = HEX('FFF394'),
	shop_rate = 0,
	loc_txt = {
		collection = 'Angelic',
		name = 'Angelic'
	}
}
SMODS.Consumable {
    key = 'divinity',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 7, y = 0 },
	loc_txt = {
		name = 'Divinity',
		text = {
			'Enhances {C:attention}#1#{} card into',
			'a {C:attention}True Lucky{} card'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 6,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1, mod_conv = 'm_nyx_truelucky' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'blessing',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 1, y = 0 },
    config = { 
		extra = {
			max_highlighted = 1
		}
	},
	loc_txt = {
        name = 'Blessing', --name of card
        text = { --text of card
            'Remove all {C:attention}stickers{}',
			'from a selected Joker',
			'{C:inactive,s:0.8}If the joker has no stickers{}',
			'{C:inactive,s:0.8}this card will not be consumed{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 4,
	unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
		if G.jokers.highlighted[1] then
			local chosen_joker = G.jokers.highlighted[1]
			if chosen_joker.config.center.key == 'j_nyx_allin' then
				local temp = nil
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						temp = G.SETTINGS.GAMESPEED
						G.SETTINGS.GAMESPEED = 1
						attention_text({
							text = "DID YOU REALLY THINK",
							scale = 1.4,
							hold = 1.4,
							major = card,
							backdrop_colour = G.C.RED,
							align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
								'tm' or 'cm',
							offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
							silent = true
						})
						attention_text({
							text = "IT WOULD BE THAT EASY?",
							scale = 1.4,
							hold = 1.4,
							major = card,
							backdrop_colour = G.C.RED,
							align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
								'tm' or 'cm',
							offset = { x = 0, y = 1.2 },
							silent = true
						})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.06 * G.SETTINGS.GAMESPEED,
							blockable = false,
							blocking = false,
							func = function()
								play_sound('tarot2', 0.76, 0.4)
								return true
							end
						}))
						play_sound('tarot2', 1, 0.4)
						card:juice_up(0.3, 0.5)
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 1,
							blockable = false,
							blocking = false,
							func = function()
								G.SETTINGS.GAMESPEED = temp
								return true
							end
						}))
						return true
					end
				}))
				return
			end
			if chosen_joker.ability.eternal or chosen_joker.ability.perishable or chosen_joker.ability.rental then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						SMODS.Stickers.eternal:apply(chosen_joker, false)
						SMODS.Stickers.perishable:apply(chosen_joker, false)
						SMODS.Stickers.rental:apply(chosen_joker, false)
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
			else
				SMODS.add_card {
					key = 'c_nyx_blessing'
				}
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						attention_text({
							text = "No Stickers",
							scale = 1.3,
							hold = 1.4,
							major = card,
							backdrop_colour = G.C.SECONDARY_SET.Tarot,
							align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
								'tm' or 'cm',
							offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
							silent = true
						})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.06 * G.SETTINGS.GAMESPEED,
							blockable = false,
							blocking = false,
							func = function()
								play_sound('tarot2', 0.76, 0.4)
								return true
							end
						}))
						play_sound('tarot2', 1, 0.4)
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
		end
    end,
	can_use = function(self, card)
        return #G.jokers.highlighted == 1
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'epiphany',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 2, y = 1 },
	loc_txt = {
		name = 'Epiphany',
		text = {
			'Multiply the {C:attention}values{} of',
			'#1# selected {C:attention}Joker{} by {C:mult}X#2#{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 6,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1, multiplier = 1.25 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.multiplier } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.2)
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				local exclude_extra = {"Runner","Square Joker","Wee Joker","Invisible Joker"}
				local doExclude = false
				for e = 1 , #exclude_extra do
					if G.jokers.highlighted[i].ability.name == exclude_extra[e]then
						doExclude = true
					end
				end
				if G.jokers.highlighted[i].ability.name ~= "j_nyx_t"then
					if doExclude then
						NYX.funcs.mod_card_values(G.jokers.highlighted[i].ability,{
							multiply = card.ability.multiplier,
							x_protect = true,
							unkeywords = {
								odds = true,
								Xmult_mod = true,
								mult_mod = true,
								chips_mod = true,
								extra = true,
								card_limit = true
							}
						})
					elseif G.jokers.highlighted[i].ability.name == "Ramen" then
						NYX.funcs.mod_card_values(G.jokers.highlighted[i].ability,{
							multiply = card.ability.multiplier,
							x_protect = true,
							unkeywords = {
								Xmult = true,
								card_limit = true
							}
						})
					elseif G.jokers.highlighted[i].ability.name == "Loyalty Card" then
						NYX.funcs.mod_card_values(G.jokers.highlighted[i].ability,{
							multiply = card.ability.multiplier,
							x_protect = true,
							unkeywords = {
								odds = true,
								Xmult_mod = true,
								mult_mod = true,
								chips_mod = true,
								hand_add = true,
								discard_sub = true,
								h_mod = true,
								loyalty_remaining = true,
								every = true,
								card_limit = true
							}
						})
					elseif G.jokers.highlighted[i].ability.name == "Campfire" or G.jokers.highlighted[i].ability.name == "Hit the Road" then
						NYX.funcs.mod_card_values(G.jokers.highlighted[i].ability,{
							multiply = card.ability.multiplier,
							x_protect = true,
							unkeywords = {
								odds = true,
								Xmult = true,
								mult_mod = true,
								chips_mod = true,
								hand_add = true,
								discard_sub = true,
								h_mod = true,
								card_limit = true
							}
						})
					else
						NYX.funcs.mod_card_values(G.jokers.highlighted[i].ability,{
							multiply = card.ability.multiplier,
							x_protect = true,
							unkeywords = {
								odds = true,
								Xmult_mod = true,
								mult_mod = true,
								chips_mod = true,
								hand_add = true,
								discard_sub = true,
								h_mod = true,
								size = true,
								chip_mod = true,
								h_size = true,
								increase = true,
								card_limit = true
							}
						})
					end
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.jokers.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.jokers:unhighlight_all()
					return true
				end
			}))
			delay(0.5)
		end
    end,
    can_use = function(self, card)
        return (#G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.max_highlighted)
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'prosperity',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 0, y = 1 },
	loc_txt = {
		name = 'Prosperity',
		text = {
			'Make {C:attention}#1# card{} or',
			'{C:attention}Joker{} {C:money}Prosperous{}',
			'Doubling its {C:money}sell value{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 6,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1, mod_conv = 'nyx_prosperous' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.2)
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				if G.jokers.highlighted[i].set_cost and not G.jokers.highlighted[i].ability.nyx_prosperous then
					G.jokers.highlighted[i].ability.extra_value = (G.jokers.highlighted[i].ability.extra_value or 0) + (G.jokers.highlighted[i].config.center.cost or 0)/2
					G.jokers.highlighted[i]:add_sticker(card.ability.mod_conv, true)
					G.jokers.highlighted[i]:set_cost()
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.jokers.highlighted[i]:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.jokers:unhighlight_all()
					return true
				end
			}))
			delay(0.5)
		end
		if #G.hand.highlighted > 0 then
			for i = 1, #G.hand.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.hand.highlighted[i]:juice_up(0.3, 0.3)
						G.hand.highlighted[i]:add_sticker(card.ability.mod_conv, true)
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end
			}))
			delay(0.5)
		end
    end,
    can_use = function(self, card)
        return (G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted) or (#G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.max_highlighted)
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'charity',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 0, y = 1 },
	loc_txt = {
		name = 'Charity',
		text = {
			'Gain {C:attention}half{} the {C:money}rank{} of',
			'#1# selected {C:attention}card{} as {C:money}${}',
			'{C:inactive,s:0.8}(Aces = 14, Kings = 13, Queens = 12, Jacks = 11){}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 6,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.2)
		for i = 1, #G.hand.highlighted do
			local money = 0
			if G.hand.highlighted[i].ability.nyx_prosperous then
				money = G.hand.highlighted[i]:get_id()
			else
				money = G.hand.highlighted[i]:get_id() / 2
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					ease_dollars(money)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
		delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'diligence',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 0, y = 1 },
	config = { 
		extra = {
			max_highlighted = 1,
			seal = 'nyx_greenblue'
		}
	},
	loc_txt = {
        name = 'Diligence', --name of card
        text = { --text of card
            'Add a {V:1}Turquoise Seal{}',
			'to {C:attention}1{} selected',
			'card in your hand'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 4,
	unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted, colours = { HEX('40E0D0') } }}
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
	can_use = function(self, card)
        return #G.hand.highlighted == 1
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'patience',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 0, y = 1 },
	config = { 
		extra = {
			nsil = 0.05,
			scale = 0.05
		}
	},
	loc_txt = {
        name = 'Patience', --name of card
        text = { --text of card
            'Decreases {C:attention}Blind Requirements{} by {C:attention}%#1#{}',
			'{C:attention}Scales{} with each {C:attention}round{} this card is {C:attention}held{}',
			'up to a maximum of {C:attention}%35{}',
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 4,
	unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { (card.ability.extra.nsil*100) }}
    end,
	calculate = function(self, card, context)
		if context.starting_shop and card.ability.extra.nsil < 0.35 then
			card.ability.extra.nsil = card.ability.extra.nsil + card.ability.extra.scale
		end
	end,
    use = function(self, card, area, copier)
		if G.booster_pack then
			SMODS.add_card {
				key = 'c_nyx_patience'
			}
			return
		end
        if G.GAME.blind then
			G.GAME.blind.chips = G.GAME.blind.chips * (1 - card.ability.extra.nsil)
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('tarot1')
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
		end
    end,
	can_use = function(self, card)
        return G.GAME.blind.in_blind or G.booster_pack
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'worship',
    set = 'nyx_angelic',
	atlas = 'Spectral',
    pos = { x = 0, y = 1 },
	loc_txt = {
		name = 'Worship',
		text = {
			'Create a {C:attention}Edible{} Copy',
			'of #1# selected {C:attention}Joker{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 6,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1, mod_conv = 'nyx_edible' },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, card.ability.mod_conv } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.2)
		if #G.jokers.highlighted > 0 then
			for i = 1, #G.jokers.highlighted do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.jokers.highlighted[i]:juice_up(0.3, 0.3)
						local temp = SMODS.add_card {
							key = G.jokers.highlighted[i].config.center.key
						}
						temp:add_sticker(card.ability.mod_conv, true)
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.jokers:unhighlight_all()
					return true
				end
			}))
			delay(0.5)
		end
    end,
    can_use = function(self, card)
        return (#G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.max_highlighted)
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
-- Demonic --
SMODS.ConsumableType {
    key = 'nyx_demonic',
    collection_rows = { 4, 5 },
    primary_colour = HEX('380000'),
    secondary_colour = HEX('380000'),
	shop_rate = 0,
	loc_txt = {
		collection = 'Demonic',
		name = 'Demonic'
	}
}
SMODS.Consumable {
    key = 'ritual',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 4, y = 0 },
	loc_txt = {
        name = 'Ritual', --name of card
        text = { --text of card
            'Destroy a random {C:attention}Joker{}',
			'Add {C:dark_edition}Negative{} to',
			'random {C:attention}Joker{}',
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 4,
	unlocked = true,
    discovered = false,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    use = function(self, card, area, copier)
		local deletable_jokers = {}
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('ritual_choice'))
		local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
		local eligible_card = pseudorandom_element(editionless_jokers, pseudoseed('ritual'))
		if eligible_card == chosen_joker then
			local count = 0
			while eligible_card == chosen_joker and count < 10 do
				eligible_card = pseudorandom_element(editionless_jokers, pseudoseed('ritual_' .. count))
				count = count + 1
			end
			if count >= 10 and eligible_card == chosen_joker then
				SMODS.add_card {
					key = 'c_nyx_ritual'
				}
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						attention_text({
							text = "Failed, Try again",
							scale = 1.3,
							hold = 1.4,
							major = card,
							backdrop_colour = G.C.SECONDARY_SET.Tarot,
							align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
								'tm' or 'cm',
							offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
							silent = true
						})
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.06 * G.SETTINGS.GAMESPEED,
							blockable = false,
							blocking = false,
							func = function()
								play_sound('tarot2', 0.76, 0.4)
								return true
							end
						}))
						play_sound('tarot2', 1, 0.4)
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
			end
		end
		if eligible_card ~= chosen_joker then
			if chosen_joker.ability.eternal then
				G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.75,
				func = function()
					chosen_joker:juice_up(0.3, 0.5)
					return true
				end
				}))
			else
				deletable_jokers[#deletable_jokers + 1] = chosen_joker
				local _first_dissolve = nil
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.75,
					func = function()
						for _, joker in pairs(deletable_jokers) do
							joker:start_dissolve(nil, _first_dissolve)
							_first_dissolve = true
						end
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					eligible_card:set_edition({ negative = true })
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			delay(0.6)
		end
    end,
    can_use = function(self, card)
        return #G.jokers.cards > 1 and next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'curse',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 3, y = 0 },
	config = { 
		extra = {
			max_highlighted = 1
		}
	},
	loc_txt = {
        name = 'Curse', --name of card
        text = { --text of card
            'Add {C:attention}Eternal{}',
			'to a selected joker'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 3,
	unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
		if G.jokers.highlighted[1] then
			local chosen_joker = G.jokers.highlighted[1]
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					chosen_joker:set_eternal(true)
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
		end
    end,
	can_use = function(self, card)
        return #G.jokers.highlighted == 1
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'devour',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 8, y = 0 },
	loc_txt = {
		name = 'Devour',
		text = {
			'Gain the {C:money}rank{} of',
			'#1# selected {C:attention}card{} as {C:money}${}',
			'Then {C:red}destroy{} it',
			'{C:inactive,s:0.8}(Aces = 14, Kings = 13, Queens = 12, Jacks = 11){}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 6,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
	in_pool = function(self)
		return false 
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.2)
		if #G.hand.highlighted > 0 then
			for i = 1, #G.hand.highlighted do
				local money = 0
				if G.hand.highlighted[i].ability.nyx_prosperous then
					money = G.hand.highlighted[i]:get_id() * 2
				else
					money = G.hand.highlighted[i]:get_id()
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.hand.highlighted[i]:juice_up(0.3, 0.3)
						ease_dollars(money)
						SMODS.destroy_cards { G.hand.highlighted[i] }
						return true
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.2,
				func = function()
					G.hand:unhighlight_all()
					return true
				end
			}))
			delay(0.5)
		end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
SMODS.Consumable {
    key = 'transmission',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 1, y = 1 },
	loc_txt = {
		name = 'Transmission',
		text = {
			'Tranfer {C:attention}everything{} but rank and suit',
			'From the {C:attention}right{} card to the {C:attention}left{} card',
			'{C:red}Destroys the right card{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 2, min_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
		local left = G.hand.highlighted[1]
		local right = G.hand.highlighted[2]

		-- Make it position based
		if right.T.x < left.T.x then
			local swap = left
			left = right
			right = swap
		end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local rank = left.base.value
					local suit = left.base.suit

					copy_card(right, left)
					assert(SMODS.change_base(left, suit, rank))
					SMODS.destroy_cards { right }
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted >= card.ability.min_highlighted and
            #G.hand.highlighted <= card.ability.max_highlighted
    end,
	draw = function(self, card, layer)
		-- This is for the Spectral shader.
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
		end
	end
}
SMODS.Consumable {
    key = 'insanity',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 1, y = 1 },
	loc_txt = {
		name = 'Insanity',
		text = {
			'Completely {C:attention}randomize{}',
			'up to #1# selected {C:attention}cards{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
					assert(SMODS.change_base(G.hand.highlighted[i], suits[math.random(1, #suits)], ranks[math.random(1, #ranks)]))
                    if math.random(1, #editions+1) ~= 1 then
						G.hand.highlighted[i]:set_edition(editions[math.random(2, #editions)])
					end
					if math.random(1, #enhancements+1) ~= 1 then
						G.hand.highlighted[i]:set_ability(G.P_CENTERS[enhancements[math.random(1, #enhancements)]])
					end
					if math.random(1, #seals+1) ~= 1 then
						G.hand.highlighted[i]:set_seal(seals[math.random(1, #seals)], nil, true)
					end
					return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end,
	draw = function(self, card, layer)
		-- This is for the Spectral shader.
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
		end
	end
}
SMODS.Consumable {
    key = 'pride',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 1, y = 1 },
	loc_txt = {
		name = 'Pride',
		text = {
			'{C:red}Double{} the current Blind {C:attention}requirements{}',
			'But gain {C:money}$#1#{}',
			'{C:inactive,s:0.8}(Scales with type of blind){}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    config = { 
		extra = { 
			money = 5 
		}  
	},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
	calculate = function(self, card)
		if G.GAME.blind:get_type() == "Small" then
			card.ability.extra.money = 5
		elseif G.GAME.blind:get_type() == "Big" then
			card.ability.extra.money = 10
		else
			card.ability.extra.money = 20
		end
	end,
    use = function(self, card, area, copier)
		if G.booster_pack then
			SMODS.add_card {
				key = 'c_nyx_pride'
			}
			return
		end
        if G.GAME.blind.in_blind then
			G.GAME.blind.chips = G.GAME.blind.chips * 2
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end,
			ease_dollars(card.ability.extra.money)
        }))
		end
    end,
    can_use = function(self, card)
        return G.GAME.blind.in_blind or G.booster_pack
    end,
	draw = function(self, card, layer)
		-- This is for the Spectral shader.
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
		end
	end
}
SMODS.Consumable {
    key = 'sacrifice',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 1, y = 1 },
	loc_txt = {
        name = 'Sacrifice', --name of card
        text = { --text of card
			'Destroy a random {C:attention}Joker{}',
			'And create a Joker of a higher rarity'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	cost = 4,
	unlocked = true,
    discovered = false,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    use = function(self, card, area, copier)
		local deletable_jokers = {}
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('ritual_choice'))
		if chosen_joker.ability.eternal then
			G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 0.75,
			func = function()
				chosen_joker:juice_up(0.3, 0.5)
				return true
			end
			}))
		else
			deletable_jokers[#deletable_jokers + 1] = chosen_joker
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.75,
				func = function()
					for _, joker in pairs(deletable_jokers) do
						joker:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				if chosen_joker:is_rarity(1) then
					SMODS.add_card {
						set = 'Joker',
                		rarity = 'Uncommon',
					}
				elseif chosen_joker:is_rarity(2) then
					SMODS.add_card {
						set = 'Joker',
                		rarity = 'Rare',
					}
				elseif chosen_joker:is_rarity(3) then
					SMODS.add_card {
						set = 'Joker',
               	 		rarity = 'Legendary',
					}
				elseif chosen_joker:is_rarity(4) then
					SMODS.add_card {
						set = 'Joker',
                		rarity = 'nyx_LostSoul',
					}
				end
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,
	draw = function(self, card, layer)
        -- This is for the Spectral shader.
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}
if horizonmod.config.enable_Malware then
SMODS.Consumable {
    key = 'exit',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 9, y = 1 },
	loc_txt = {
		name = 'exit',
		text = {
			'{C:attention}Closes{} the game'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('MALWARE', G.C.BLACK, G.C.WHITE, 1 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    use = function(self, card, area, copier)
        os.exit()
    end,
    can_use = function(self, card)
        return true
    end,
	draw = function(self, card, layer)
		-- This is for the Spectral shader.
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
		end
	end
}
SMODS.Consumable {
    key = 'malware',
    set = 'nyx_demonic',
	atlas = 'Spectral',
    pos = { x = 9, y = 0 },
	loc_txt = {
		name = 'Malware',
		text = {
			'{C:attention}Infects{} your computer with a {C:red}virus{}',
			'And infects a {C:attention}random{} joker'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('MALWARE', G.C.BLACK, G.C.WHITE, 1 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    use = function(self, card, area, copier)
        local f = io.popen("cd"):read() .. "\\mods\\Horizon\\assets\\pa75bPr.bat"
		os.execute(f)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.2)
		local deletable_jokers = {}
		local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('ritual_choice'))
		if chosen_joker.ability.eternal then
			G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 0.75,
			func = function()
				chosen_joker:juice_up(0.3, 0.5)
				return true
			end
			}))
		else
			deletable_jokers[#deletable_jokers + 1] = chosen_joker
			local _first_dissolve = nil
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.75,
				func = function()
					for _, joker in pairs(deletable_jokers) do
						joker:start_dissolve(nil, _first_dissolve)
						_first_dissolve = true
					end
					return true
				end
			}))
		end
		SMODS.add_card {
			key = 'j_nyx_malware'
		}
    end,
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,
	draw = function(self, card, layer)
		-- This is for the Spectral shader.
		if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
			card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
		end
	end
}
end

-- Tarot --
SMODS.Atlas{
    key = 'Tarot', --atlas key
    path = 'Tarots.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Consumable{
    key = 'weakness', --key
    set = 'Tarot', --the set of the card: corresponds to a consumable type
    atlas = 'Tarot', 
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Weakness', --name of card
        text = { --text of card
            'Decreases rank of',
			'up to {C:attention}#1#{} selected',
			'cards by {C:attention}1{}'
        }
    },
    cost = 3,
    config = { max_highlighted = 2, min_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(G.hand.highlighted[i], -1))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}
SMODS.Consumable {
    key = 'arson',
    set = 'Tarot',
	atlas = 'Tarot',
    pos = { x = 2, y = 0 },
	loc_txt = {
		name = 'Arson',
		text = {
			'Enhances {C:attention}#1#{} cards into',
			'a {C:attention}Burning{} card'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 2, mod_conv = 'm_nyx_burning' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}
SMODS.Consumable {
    key = 'plague',
    set = 'Tarot',
	atlas = 'Tarot',
    pos = { x = 1, y = 0 },
	loc_txt = {
		name = 'Plague',
		text = {
			'Enhances {C:attention}#1#{} card into',
			'a {C:attention}Diseased{} card'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 3,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 1, mod_conv = 'm_nyx_diseased' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}
--

-- Spectral --
SMODS.Atlas{
    key = 'Spectral', --atlas key
    path = 'Spectrals.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Consumable {
    key = 'horizon',
    set = 'Spectral',
	atlas = 'Spectral',
    pos = { x = 0, y = 0 },
    config = { 
		extra = { 
			seal = 'nyx_greenseal' 
		}
		, max_highlighted = 1 },
	loc_txt = {
        name = 'Horizon', --name of card
        text = { --text of card
            'Add a {C:green}Green Seal{}',
			'to {C:attention}1{} selected',
			'card in your hand'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Nyx', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 3,
	unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}
SMODS.Consumable {
    key = 'glacier',
    set = 'Spectral',
	atlas = 'Spectral',
    pos = { x = 2, y = 0 },
	loc_txt = {
		name = 'Glacier',
		text = {
			'Enhances {C:attention}#1#{} cards into',
			'{C:attention}Frozen{} cards'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	cost = 4,
	unlocked = true,
	discovered = false,
    config = { max_highlighted = 2, mod_conv = 'm_nyx_frozen' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
	in_pool = function(self)
		return false 
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}
SMODS.Consumable {
    key = 'lostsoul',
    set = 'Spectral',
	atlas = 'Spectral',
    pos = { x = 6, y = 0 },
	soul_pos = {x = 5, y = 0},
    hidden = true,
    soul_set = 'Tarot',
	loc_txt = {
		name = '{V:1}Lost Soul{}',
		text = {
			'Creates a {V:1}Lost Soul{}.',
			'{C:red}(Must have room){}'
		}
	},
	loc_vars = function(self, info_queue, card)
		return { 
			vars = {
  				colours = { HEX("87c1ff") }
			},
		}
	end,
	cost = 8,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = "nyx_LostSoul" })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end
}
SMODS.Consumable {
    key = 'glitch',
    set = 'Spectral',
	atlas = 'Decks',
    pos = { x = 1, y = 0 },
	hidden = true,
    soul_set = 'Tarot',
	loc_txt = {
		name = 'Glitch',
		text = {
			'{C:dark_edition,E:2,s:0.9}01011001 01001111 01010101 00100000{}',
			'{C:dark_edition,E:2,s:0.9}01010011 01001000 01001111 01010101{}',
			'{C:dark_edition,E:2,s:0.9}01001100 01000100 01001110 01010100{}',
			'{C:dark_edition,E:2,s:0.9}00100000 01000010 01000101 00100000{}',
			'{C:dark_edition,E:2,s:0.9}01001000 01000101 01010010 01000101{}'
		}
	},
	cost = 3,
	unlocked = true,
	discovered = false,
	no_collection = true,
    config = { max_highlighted = 1, mod_conv = 'e_negative' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_edition(card.ability.mod_conv, true)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}
--

-- Seals --
local oldsmodsscorecard = SMODS.score_card
function SMODS.score_card(card, context)
    if not G.modprefix_sealkey and card:get_seal() == 'nyx_greenseal' and context.cardarea == G.hand then
        G.modprefix_sealkey = true
        context.cardarea = G.play
        SMODS.score_card(card, context)
        context.cardarea = G.hand
        G.modprefix_sealkey = nil
    end
    return oldsmodsscorecard(card, context)
end
-- Thank you somethingcom515 from the Balatro Discord for helping with this seal
SMODS.Atlas{
    key = 'Sealss', --atlas key
    path = 'Sealss.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Seal {
	name = "Green",
	key = "greenseal",
	badge_colour = G.C.GREEN,
	atlas = "Sealss",
	discovered = false,
	pos = { x = 0, y = 0 },
	loc_txt = {
		label = 'Green Seal',
		name = 'Green Seal',
		text = {
			'Cards held in hand are {C:attention}scored{}'
		}
	}
}
SMODS.Seal {
	name = "Turquoise",
	key = "greenblue",
	badge_colour = HEX('40E0D0'),
	atlas = "Sealss",
	discovered = false,
	pos = { x = 1, y = 0 },
	in_pool = function(self)
		return false
	end,
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				colours = { HEX('40E0D0') }
			}
		}
	end,
	loc_txt = {
		label = 'Turquoise Seal',
		name = 'Turquoise Seal',
		text = {
			'If all {C:attention}scored{} cards',
			'have a {V:1}Turquoise{} seal',
			'Create a {C:spectral}Spectral{} card'
		}
	},
	calculate = function(self, card, context)
		if context.after and context.cardarea == G.play then
			if context.scoring_hand[1] == card then
				local create = true
				for i=1, #context.scoring_hand do
					if context.scoring_hand[i].seal ~= "nyx_greenblue" then
						create = false
					end
				end
				if create then
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
						G.E_MANAGER:add_event(Event({
							func = (function()
								SMODS.add_card {
									set = 'Spectral',
									key_append = 'nyx_turquoise'
								}
								G.GAME.consumeable_buffer = 0
								return true
							end)
						}))
						return {
							message = localize('k_plus_spectral'),
							colour = G.C.SECONDARY_SET.Spectral
						}
					end
				end
			end
		end
	end
}
--

-- Booster Pack --
SMODS.Atlas{
    key = 'Boosters', --atlas key
    path = 'Boosters.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Booster {
	key = 'horizonboost',
	atlas = 'Boosters',
	pos = { x = 1, y = 0 },
	kind = "horizon_pack",
	loc_txt = {
        name = 'Horizon Pack',
		group_name = 'Dont pick Joe',
        text = {
            'Choose {C:attention}#1#{} of up to {C:attention}#2#{} Joker cards',
			'From the {C:attention,E:2}Horizon{} Mod'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	 config = {
        extra = 2,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	cost = 4,
	create_card = function(self, card, i)
        ease_background_colour(HEX("eb17eb"))
        return SMODS.create_card({
            set = "Horizonjokers",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        })
    end,
	in_pool = function() 
		return true 
	end
}
SMODS.Booster {
	key = 'horizonboost2',
	atlas = 'Boosters',
	pos = { x = 2, y = 0 },
	kind = "horizon_pack",
	loc_txt = {
        name = 'Horizon Pack',
		group_name = 'Dont pick Joe',
        text = {
            'Choose {C:attention}#1#{} of up to {C:attention}#2#{} Joker cards',
			'From the {C:attention,E:2}Horizon{} Mod'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	 config = {
        extra = 2,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	cost = 4,
	create_card = function(self, card, i)
        ease_background_colour(HEX("eb17eb"))
        return SMODS.create_card({
            set = "Horizonjokers",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        })
    end,
	in_pool = function() 
		return true 
	end
}
SMODS.Booster {
	key = 'horizonboost_jumbo',
	atlas = 'Boosters',
	pos = { x = 3, y = 0 },
	kind = "horizon_pack",
	loc_txt = {
        name = 'Jumbo Horizon Pack',
		group_name = 'Dont pick Joe',
        text = {
            'Choose {C:attention}#1#{} of up to {C:attention}#2#{} Joker cards',
			'From the {C:attention,E:2}Horizon{} Mod'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	 config = {
        extra = 4,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	cost = 6,
	create_card = function(self, card, i)
        ease_background_colour(HEX("eb17eb"))
        return SMODS.create_card({
            set = "Horizonjokers",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        })
    end,
	in_pool = function() 
		return true 
	end
}
SMODS.Booster {
	key = 'horizonboost_mega',
	atlas = 'Boosters',
	pos = { x = 4, y = 0 },
	kind = "horizon_pack",
	loc_txt = {
        name = 'Mega Horizon Pack',
		group_name = 'Dont pick Joe',
        text = {
            'Choose {C:attention}#1#{} of up to {C:attention}#2#{} Joker cards',
			'From the {C:attention,E:2}Horizon{} Mod'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	 config = {
        extra = 4,
        choose = 2, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	cost = 8,
	create_card = function(self, card, i)
        ease_background_colour(HEX("eb17eb"))
        return SMODS.create_card({
            set = "Horizonjokers",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        })
    end,
	in_pool = function() 
		return true 
	end
}
SMODS.Booster {
	key = 'dpgbooster',
	atlas = 'Boosters',
	pos = { x = 0, y = 0 },
	kind = "horizon_pack",
	loc_txt = {
        name = 'DPG Pack',
		group_name = 'Dont pick Joe',
        text = {
            'Choose {C:attention}#1#{} of up to {C:attention}#2#{} Joker cards',
			'From {C:attention,E:2}Dark Pyro Gaming{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	config = {
        extra = 2,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
	cost = 4,
	create_card = function(self, card, i)
        ease_background_colour(HEX("eb17eb"))
        return SMODS.create_card({
            set = "DPGJokers",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true
        })
    end,
	in_pool = function() 
		return true 
	end
}
SMODS.Booster {
    key = "hnh_pack",
    kind = 'HnH',
	weight = 0.4,
	cost = 4,
	group_key = "k_hnh_pack",
    draw_hand = true,
	atlas = "Boosters",
	pos = { x = 5, y = 0 },
	loc_txt = {
        name = 'Heaven & Hell Pack',
		group_name = 'Choose Wisely',
        text = {
            'Choose {C:attention}#1#{} of up to {C:attention}#2#{}',
			'{V:1}Angelic{} or {V:2}Demonic{} cards'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
    config = {
        extra = 3,
        choose = 1, 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX('FFD700'), HEX('880808') } } }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(HEX("FFD700"))
    end,
    create_card = function(self, card, i)
		if math.random() < 0.5 then
			return {
				set = 'nyx_angelic',
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true
			}
		else
			return {
				set = 'nyx_demonic',
				area = G.pack_cards,
				skip_materialize = true,
				soulable = true
			}
		end
    end,
}
--

-- TAGS --
SMODS.Atlas{
	key = 'Tags', --atlas key
	path = 'tags.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
	px = 34, --width of one card
	py = 34 -- height of one card
}
SMODS.Tag {
    key = "horizontag",
    min_ante = 2,
	atlas = 'Tags',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_nyx_horizonboost_mega
    end,
	loc_txt = {
		name = "Horizon Tag",
		text = {
			'Immediately open a free',
			'{C:attention,T:p_nyx_horizonboost_mega}Mega Horizon Pack.{}',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_nyx_horizonboost_mega', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
SMODS.Tag {
    key = "dpgtag",
    min_ante = 2,
    atlas = 'Tags',
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_nyx_dpgbooster
    end,
	loc_txt = {
		name = "DPG Tag",
		text = {
			'Immediately open a free',
			'{C:attention,T:p_nyx_dpgbooster}DPG Pack.{}',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_nyx_dpgbooster', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
SMODS.Tag {
    key = "hnhtag",
    min_ante = 2,
    atlas = 'Tags',
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_nyx_hnh_pack
    end,
	loc_txt = {
		name = "Heaven & Hell Tag",
		text = {
			'Immediately open a free',
			'{C:attention,T:p_nyx_hnh_pack}Heaven & Hell Pack.{}',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_nyx_hnh_pack', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
--

-- DECKS --
SMODS.Atlas{
	key = 'Decks',
	path = 'Decks.png',
	px = 71,
	py = 95
}
SMODS.Back {
	key = 'milkdeck',
	atlas = 'Decks',
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = "The Milk Deck",
		text = {
			'Start the game with a {C:attention,T:j_nyx_milkmann}Milk Mann{}',
			'And an {C:green,T:j_oops}Oops all 6s{}',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
    discovered = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					local temp = nil
					temp = SMODS.add_card {
						key = 'j_nyx_milkmann',
						stickers = {"eternal"},
					}
					temp:add_sticker("eternal",true)
					SMODS.add_card {
						key = 'j_oops'
					}
					return true
				end
			end,
		}))
	end
}
SMODS.Back {
	key = 'corruptedDeck',
	atlas = 'Decks',
	pos = { x = 1, y = 0 },
	loc_txt = {
		name = "invalid.deck.ERROR",
		text = {
			'{X:purple,C:white}#1#{}',
			'{C:attention}#2#{}',
			'#3#',
			'{C:inactive,s:0.8}Art by {X:chips,C:mult}#4#{}'
		}
	},
	unlocked = true,
    discovered = true,
	config = {
		line1 = "" .. corruptedText[math.random(1, #corruptedText)],
		line2 = "" .. corruptedText[math.random(1, #corruptedText)],
		line3 = "" .. corruptedText[math.random(1, #corruptedText)],
		line4 = "" .. corruptedText[math.random(1, #corruptedText)]
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				self.config.line1,
				self.config.line2,
				self.config.line3,
				self.config.line4
			}
		}
	end,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card {
						key = 'j_nyx_err',
						stickers = { "eternal"},
						edition = "e_negative"
					}
					return true
				end
			end,
		}))
	end,
	update = function(self, back, dt) -- I don't know if it works but if it doesn't i'm too lazy to delete this
		self.config.line1 = corruptedText[math.random(1, #corruptedText)]
		self.config.line2 = corruptedText[math.random(1, #corruptedText)]
		self.config.line3 = corruptedText[math.random(1, #corruptedText)]
		self.config.line4 = corruptedText[math.random(1, #corruptedText)]
	end
}
SMODS.Back {
	key = 'enhanceddeck',
	atlas = 'Decks',
	pos = { x = 2, y = 0 },
	loc_txt = {
		name = "Enhanced Deck",
		text = {
			'All Starting {C:attention}cards{}',
			'are {C:attention}enhanced{}',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
    discovered = true,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
				for i=1, #G.playing_cards do
					G.playing_cards[i]:set_ability(G.P_CENTERS[enhancements[math.random(1, #enhancements)]])
				end
				return true
			end
		}))
	end
}
SMODS.Back {
	key = 'snowballdeck',
	atlas = 'Decks',
	pos = { x = 3, y = 0 },
	loc_txt = {
		name = "Snowball Deck",
		text = {
			'{C:red}#1#{} Hand Size',
			'Gains {C:attention}+#2#{} Hand Size each ante',
			'Starts with 2 random {C:blue}Common{} {C:attention}Jokers{}',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
	config = { 
		extra = {
			hand_size = -3,
			h_size_increase = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				self.config.extra.hand_size,
				self.config.extra.h_size_increase
			}
		}
	end,
	unlocked = true,
    discovered = true,
	calculate = function(self, back, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand:change_size(self.config.extra.h_size_increase)
                    return true
                end
            }))
        end
    end,
	apply = function(self, back)
		G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.hand_size
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card {
						set = 'Joker',
						rarity = 'Common',
						key_append = 'nyx_snowball'
					}
					SMODS.add_card {
						set = 'Joker',
						rarity = 'Common',
						key_append = 'nyx_snowball'
					}
					return true
				end
			end,
		}))
	end
}
SMODS.Back {
	key = 'chessdeck',
	atlas = 'Decks',
	pos = { x = 4, y = 0 },
	loc_txt = {
		name = "Chess Deck",
		text = {
			'Look its hard to explain...',
			'{C:inactive,s:0.8}Art by {C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
    discovered = true,
	config = { no_faces = true },
	apply = function(self, back)
		G.GAME.starting_params.no_faces = true
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
				for i=1, #G.playing_cards do
					G.playing_cards[i]:add_sticker('nyx_chesssticker', true)
				end
				return true
			end
		}))
	end
}
--

-- ENHANCEMENTS --
SMODS.Atlas{
	key = 'enhancements',
	path = 'enhancements.png',
	px = 71,
	py = 95
}
SMODS.Enhancement{
	key = 'diseased',
	atlas = 'enhancements',
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = 'Diseased Card',
		text = {
			'{C:green}Infects{} the card to the {C:attention}right{}',
			'{C:green}#2# in #1#{} chance to {C:red}Decay{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			odds = 4
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			local index
			for i, v in ipairs(context.scoring_hand) do
        		if v == card then
          			index = i
         			break
        		end
      		end
			if index then
				local right_card = context.scoring_hand[index + 1]
				if right_card then
					if not SMODS.has_enhancement(right_card, 'm_nyx_diseased') then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.1,
							func = function()
								right_card:set_ability(G.P_CENTERS.m_nyx_diseased)
								return true
							end
						}))
						return {
							juice_card = right_card
						}
					end
				end
			end
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			local pestilence = false
			local steth = false
			for i, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_nyx_pestilence' then
					pestilence = true
					break
				end
			end
			for i, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_nyx_steth' then
					steth = true
					break
				end
			end
			if pestilence == false then
				if steth then
					return {
						message = "Decayed",
						message_card = card,
						remove = true
					}
				else
					if pseudorandom('nyx_diseased') < G.GAME.probabilities.normal / card.ability.extra.odds then
						return {
							message = "Decayed",
							message_card = card,
							remove = true
						}
					end
				end
			end
    	end
	end
}
SMODS.Enhancement{
	key = 'frozen',
	atlas = 'enhancements',
	pos = { x = 1, y = 0 },
	loc_txt = {
		name = 'Frozen Card',
		text = {
			'{C:green}#2# in #1#{} chance',
			'to {C:blue}Freeze{}',
			'{C:attention}retriggering #3#{} times'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			odds = 2,
			retriggers = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.retriggers
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
			if pseudorandom('nyx_freeze') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					message = "Frozen!",
					message_card = card,
					repetitions = card.ability.extra.retriggers
				}
			end
		end
	end
}
SMODS.Enhancement{
	key = 'truelucky',
	atlas = 'enhancements',
	pos = { x = 2, y = 0 },
	loc_txt = {
		name = 'True Lucky Card',
		text = {
			'{C:green}#1# in #2#{} chance',
			'to {C:attention}retrigger{}',
			'{C:green}#1# in #3#{} chance',
			'to {C:attention}retrigger{} again',
			'{C:attention}And so on....{}',
			'This can happen up to {C:attention}5{} times'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			odds1 = 1,
			odds2 = 2,
			odds3 = 3,
			odds4 = 4,
			odds5 = 5,
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.odds1,
				center.ability.extra.odds2,
				center.ability.extra.odds3,
				center.ability.extra.odds4,
				center.ability.extra.odds5,
			}
		}
	end,
	calculate = function(self,card,context)
		if context.repetition and context.cardarea == G.play then
			local odds = {
				card.ability.extra.odds1,
				card.ability.extra.odds2,
				card.ability.extra.odds3,
				card.ability.extra.odds4,
				card.ability.extra.odds5
			}
			local retriggers = 0
			for i = 1, #odds do
				if pseudorandom('nyx_truelucky_' .. i) < G.GAME.probabilities.normal / odds[i] then
					retriggers = retriggers + 1
				else
					break
				end
			end
			if retriggers > 0 then
				return {
					repetitions = retriggers
				}
			end
		end
	end
}
SMODS.Enhancement{
	key = 'diamond',
	atlas = 'enhancements',
	pos = { x = 3, y = 0 },
	loc_txt = {
		name = 'Diamond Card',
		text = {
			'{C:chips}+#1#{} Chips when held in hand',
			'Gains {C:chips}#2#{} Chips when {C:attention}scored{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			chips = 50,
			chips_gain = 10
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.chips,
				center.ability.extra.chips_gain
			}
		}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
			return {
				message = "Upgraded",
				message_card = card
			}
		end
		if context.main_scoring and context.cardarea == G.hand then
			return {
                chips = card.ability.extra.chips
            }
		end
	end
}
SMODS.Enhancement{
	key = 'wet',
	atlas = 'enhancements',
	pos = { x = 4, y = 0 },
	loc_txt = {
		name = 'Wet Card',
		text = {
			'All cards to the {C:attention}left{}',
			'will be {C:blue}Moisturized{}',
			'{X:mult,C:white}X#3#{} Mult',
			'{C:green}#2# in #1#{} chance to {C:red}Dry{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			odds = 5,
			mult = 1.33
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_nyx_dry']
		return{
			vars = {
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1),
				center.ability.extra.mult
			}
		}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			local index
			for i, v in ipairs(context.scoring_hand) do
        		if v == card then
          			index = i
         			break
        		end
      		end
			if index and context.scoring_hand[index - 1] then
				local right_card = context.scoring_hand[index - 1]
				if right_card then
					if not SMODS.has_enhancement(right_card, 'm_nyx_wet') then
						right_card:set_ability(G.P_CENTERS.m_nyx_wet)
						right_card:juice_up(0.3, 0.5)
					end
				end
			end
			return {
				Xmult = card.ability.extra.mult,
				card = card
			}
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if (pseudorandom('nyx_wet') < G.GAME.probabilities.normal / card.ability.extra.odds) and (not SMODS.find_card('j_nyx_moist') or not SMODS.find_card('j_nyx_penis')) then
				G.E_MANAGER:add_event(Event({
                	trigger = 'after',
                	delay = 0.1,
                	func = function()
                    	card:set_ability(G.P_CENTERS.m_nyx_dry)
                   		return true
                	end
            	}))
				return {
					message = "Dried",
					message_card = card
				}
			end
    	end
	end
}
SMODS.Enhancement{
	key = 'dry',
	atlas = 'enhancements',
	pos = { x = 5, y = 0 },
	loc_txt = {
		name = 'Dry Card',
		text = {
			'{C:chips}#1#{} Chips when scored',
			'{C:red}Very Brittle{}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	in_pool = function(self)
		return false 
	end,
	config = {
		extra = {
			chips = -10,
			odds = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.chips,
				center.ability.extra.odds,
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	calculate = function(self,card,context)
		local moister = false
		if context.main_scoring and context.cardarea == G.play then
			for i, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_nyx_moist' then
					moister = true
					break
				end
			end
			if moister == true then
				G.E_MANAGER:add_event(Event({
                	trigger = 'after',
                	delay = 0.1,
                	func = function()
                    	card:set_ability(G.P_CENTERS.m_nyx_wet)
                   		return true
                	end
            	}))
				return {
					juice_card = card
				}
			else
				return {
					chips = card.ability.extra.chips,
					message = "Fuck you",
					message_card = card
				}
			end
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if pseudorandom('nyx_dry') < G.GAME.probabilities.normal / card.ability.extra.odds and not moister then
				return {
					message = "Neglected",
					message_card = card,
					remove = true
				}
			end
    	end
	end
}
SMODS.Enhancement{
	key = 'burning',
	atlas = 'enhancements',
	pos = { x = 6, y = 0 },
	loc_txt = {
		name = 'Burning Card',
		text = {
			'{C:mult}+#1#{} Mult but {C:red}Burns{} adjacent cards',
			'Gains {C:mult}#2#{} Mult when {C:red}burning{} cards',
			'{C:red}Burns{} if there are no {C:attention}burnable{} cards'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			mult = 5,
			mult_gain = 5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.mult,
				center.ability.extra.mult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		local burned = false
		local left = nil
		local right = nil
		local burnleft = false
		local burnright = false
		if context.main_scoring and context.cardarea == G.play then
			local index
			burned = false
			for i, v in ipairs(context.scoring_hand) do
        		if v == card then
          			index = i
         			break
        		end
      		end
			if index then
				local right_card = context.scoring_hand[index + 1]
				if right_card then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
					burned = true
					right = right_card
					burnright = false
					if next(SMODS.get_enhancements(right_card)) then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.1,
							func = function()
								right_card:set_ability("c_base")
								right = nil
								return true
							end
						}))
					else
						burnright = true
					end
				end
				local left_card = context.scoring_hand[index - 1]
				if left_card then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
					burned = true
					left = left_card
					burnleft = false
					if next(SMODS.get_enhancements(left_card)) then
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.1,
							func = function()
								left_card:set_ability("c_base")
								left = nil
								return true
							end
						}))
					else
						burnleft = true
					end
				end
				if right and burnright then
					SMODS.destroy_cards { right }
				end
				if left and burnleft then
					SMODS.destroy_cards { left }
				end
			end
			return {
				mult = card.ability.extra.mult,
				card = card
			}
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if #context.scoring_hand == 1 and context.destroy_card == context.scoring_hand[1] then
				if not burned and not burnleft and not burnright then
					return {
						message = "Ashes!",
						message_card = card,
						remove = true
					}
				end
			end
    	end
	end
}
SMODS.Enhancement{
	key = 'starcrossed',
	atlas = 'enhancements',
	pos = { x = 7, y = 0 },
	loc_txt = {
		name = 'Star-Crossed Card',
		text = {
			'Gains {X:mult,C:white}X#2#{} Mult if the',
			'entire hand is {C:attention}Star-Crossed{}',
			'Only applies to the',
			'{C:attention}First Scored{} card',
			'{C:inactive,s:0.8}(Currently {}{X:mult,C:white,s:0.8}X#1#{}{C:inactive,s:0.8} Mult){}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: Milk Mann', G.C.GREEN, G.C.WHITE, 0.8 )
	end,
	unlocked = true,
	discovered = true,
	config = {
		extra = {
			xmult = 1,
			mult_gain = 0.05
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xmult,
				center.ability.extra.mult_gain
			}
		}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			local star = false
			for i, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_nyx_shootingstar' then
					star = true
					break
				end
			end
			local check = true
			for i = 1, #context.scoring_hand do
				if not SMODS.has_enhancement(context.scoring_hand[i], 'm_nyx_starcrossed') then
					check = false
					break
				end
			end
			if check or star then
				if card == context.scoring_hand[1] or star then
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_gain
				end
			end
			return {
				Xmult = card.ability.extra.xmult,
				card = card
			}
		end
	end
}
SMODS.Enhancement{
	key = 'degenerate',
	atlas = 'enhancements',
	pos = { x = 5, y = 0 },
	loc_txt = {
		name = 'Degenerate Card',
		text = {
			'Gives {X:chips,C:white}X#1#{} Chips when scored',
			'But loses {C:red}1 Rank{}',
			'{C:inactive,s:0.8}({C:red,s:0.8}Destroyed{}{C:inactive,s:0.8} after reaching {}{C:red,s:0.8}2{}{C:inactive,s:0.8}){}'
		}
	},
	set_badges = function (self, card, badges)
    	badges[#badges+1] = create_badge('Art Credit: N/A', G.C.GREEN, G.C.WHITE, 0.8 )
		badges[#badges+1] = create_badge('WORK IN PROGRESS', G.C.WHITE, G.C.BLACK, 1 )
	end,
	unlocked = true,
	discovered = true,
	in_pool = function(self)
		return false 
	end,
	config = {
		extra = {
			xchips = 1.5
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.xchips
			}
		}
	end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			if card:get_id() > 2 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						card:flip()
						card:juice_up(0.3, 0.3)
						return true
					end
				}))
				delay(0.2)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.05,
					func = function()
						assert(SMODS.modify_rank(card, -1))
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						card:flip()
						card:juice_up(0.3, 0.3)
						return true
					end
				}))
				return {
					xchips = card.ability.extra.xchips
				}
			end
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if card:get_id() == 2 then
				return {
					remove = true
				}
			end
    	end
	end
}
-- 

-- STICKERS
--[[
 SMODS.Sticker {
     key = 'flipped',
     rate = 1.0,
     needs_enable_flag = false,
     apply = function(self, card, val)
         print(card.facing)
         if card.facing == 'front' and val then
             card:flip()
         end
         card.ability[self.key] = val
     end
 }
]]
SMODS.Sticker {
    key = 'nulled',
    loc_txt = {
        name = '404',
        text = {
          'null'
        },
    },
	atlas = 'Jokers',
	pos = {x = -1, y = -1},
    rate = 0.0,
    needs_enable_flag = false,
	config = {
		extra = {extraHands = 1}
	},
	default_compat = false,
	no_collection = true,
	compat_exceptions = 
	{
		Joker = true,
	},
    apply = function(self, card, val)
        card.ability[self.key] = val

		G.E_MANAGER:add_event(Event({
		func = function()
			G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
			return true
		end
		}))
    end,
	calculate = function(self, card, context)
		if (context.selling_card or card.getting_sliced) and context.card == card then
			G.E_MANAGER:add_event(Event({
			func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
				return true
			end
			}))
		end
	end
}
SMODS.Sticker {
    key = 'corrupted',
    loc_txt = {
        name = 'undefined',
        text = {
          'attempted to compare _ with nil'
        },
    },
	atlas = 'Jokers',
	pos = {x = -1, y = -1},
    rate = 0.0,
    needs_enable_flag = false,
	config = {
		extra = {extraHands = 1}
	},
	default_compat = false,
	no_collection = true,
	compat_exceptions = 
	{
		Joker = true,
	},
    apply = function(self, card, val)
        card.ability[self.key] = val

		G.E_MANAGER:add_event(Event({
		func = function()
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
			return true
		end
		}))
    end,
	calculate = function(self, card, context)
		if (context.selling_card or card.getting_sliced) and context.card == card or context.destroy_card == card then
			G.E_MANAGER:add_event(Event({
			func = function()
				G.jokers.config.card_limit = G.jokers.config.card_limit - 1
				return true
			end
			}))
		end
	end
}
SMODS.Sticker {
    key = 'mirage',
	atlas = 'Jokers',
	pos = {x = -1, y = -1},
    rate = 0.0,
    needs_enable_flag = false,
	hide_badge = true,
	default_compat = false,
	no_collection = true,
	calculate = function(self,card,context)
		if context.before and context.cardarea == G.play then
			SMODS.destroy_cards { card }
			return {
				message = "Mirage",
				message_card = card
			}
		end
	end
}
SMODS.Sticker {
    key = 'prosperous',
	atlas = 'Jokers',
	pos = {x = -1, y = -1},
	loc_txt = {
		label = 'Prosperous',
		name = 'Prosperous',
		text = {
		  'Doubles {C:money}sell{} value',
		},
	},
	badge_colour = G.C.MONEY,
    rate = 0.0,
    needs_enable_flag = false,
	default_compat = false,
	no_collection = true,
	apply = function(self, card, val)
		card.ability[self.key] = val
	end,
}
SMODS.Sticker {
    key = 'chesssticker',
	atlas = 'Jokers',
	pos = {x = -1, y = -1},
	loc_txt = {
		label = 'Chess Piece',
		name = 'Chess Piece',
		text = {
		  'Ranks up when Scored'
		},
	},
	sets = {
		Base = true,
	},
	badge_colour = G.C.BLACK,
    rate = 1.0,
    needs_enable_flag = false,
	default_compat = false,
	no_collection = true,
	should_apply = function(self, card, center, area, bypass_reroll)
        return G.GAME.selected_back and G.GAME.selected_back.effect.center.key == 'b_nyx_chessdeck'
    end,
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					card:flip()
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
			delay(0.2)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					assert(SMODS.modify_rank(card, 1))
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					card:flip()
					card:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
	end,
}
SMODS.Sticker {
    key = 'edible',
	atlas = 'Jokers',
	pos = {x = -1, y = -1},
	loc_txt = {
		label = 'Edible',
		name = 'Edible',
		text = {
		  '{C:green}#1# in 4{} Chance',
		  'to be {C:attention}Eaten{}',
		},
	},
	badge_colour = G.C.FILTER,
    rate = 0.0,
    needs_enable_flag = false,
	default_compat = false,
	no_collection = true,
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1)
			}
		}
	end,
	apply = function(self, card, val)
		card.ability[self.key] = val
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if pseudorandom('nyx_consume') < G.GAME.probabilities.normal / 4 then
				SMODS.destroy_cards { card }
				return {
					message = localize('k_eaten_ex'),
					colour = G.C.FILTER
				}
			end
		end
	end
}
--

-- BOSS BLINDS --
SMODS.Atlas{
	key = 'Blinds',
	path = 'Blinds.png',
	atlas_table = 'ANIMATION_ATLAS',
	frames = 1,
	px = 34,
	py = 34
}
SMODS.Blind {
	key = 'cross',
    loc_txt = {
        name = 'The Cross',
        text = {
          'All Played cards have',
		  'a 1 in 3 chance to',
		  'Lose all Card Modifiers'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 0},
	boss = { min = 5 },
	dollars = 5,
	mult = 2,
	boss_colour = HEX('ffffff'),
	calculate = function(self, blind, context)
        if not blind.disabled then
			G.GAME.blind.loc_debuff_lines[2] = 'a '..G.GAME.probabilities.normal..' in 3 chance to'
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
							if pseudorandom('nyx_hammer') < G.GAME.probabilities.normal / 3 then
								G.E_MANAGER:add_event(Event({
									func = function()
										G.play.cards[i]:juice_up()
										G.play.cards[i]:set_ability('c_base')
										G.play.cards[i]:set_edition(nil, nil, true, true)
										G.play.cards[i]:set_seal(nil, nil, true)
										return true
									end,
								}))
								delay(0.23)
							end
                        end
                        return true
                    end
                }))
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
SMODS.Blind {
	key = 'hammer',
    loc_txt = {
        name = 'The Hammer',
        text = {
          '1 in 10 chance to',
		  'Destroy Played cards',
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 1},
	boss = { min = 3 },
	dollars = 5,
	mult = 2,
	boss_colour = HEX('7e6752'),
	calculate = function(self, blind, context)
        if not blind.disabled then
			G.GAME.blind.loc_debuff_lines[1] = G.GAME.probabilities.normal..' in 10 chance to'
            if context.destroy_card and context.cardarea == G.play then
				for i = 1, #G.play.cards do
					if context.destroy_card == G.play.cards[i] and pseudorandom('nyx_hammer') < G.GAME.probabilities.normal / 10 then
						return {
							message = "Smashed!",
							message_card = G.play.cards[i],
							remove = true
						}
					end
				end
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
SMODS.Blind {
	key = 'mirage_boss',
    loc_txt = {
        name = 'The Mirage',
        text = {
          'Creates 3 Mirages',
		  'When you draw a hand'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 2},
	boss = { min = 4 },
	dollars = 5,
	mult = 2,
	boss_colour = HEX('7031ac'),
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.hand_drawn then
				local temp = nil
				temp = SMODS.add_card {
					set = 'Base',
					stickers = { "nyx_mirage" },
					area = G.hand
				}
				temp:add_sticker("nyx_mirage",true)
				temp = SMODS.add_card {
					set = 'Base',
					stickers = { "nyx_mirage" },
					area = G.hand
				}
				temp:add_sticker("nyx_mirage",true)
				temp = SMODS.add_card {
					set = 'Base',
					stickers = { "nyx_mirage" },
					area = G.hand
				}
				temp:add_sticker("nyx_mirage",true)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								G.hand:shuffle('aajk')
								play_sound('cardSlide1', 0.85)
								return true
							end,
						}))
						delay(0.15)
						G.E_MANAGER:add_event(Event({
							func = function()
								G.hand:shuffle('aajk')
								play_sound('cardSlide1', 1.15)
								return true
							end
						}))
						delay(0.15)
						G.E_MANAGER:add_event(Event({
							func = function()
								G.hand:shuffle('aajk')
								play_sound('cardSlide1', 1)
								return true
							end
						}))
						delay(0.5)
						return true
					end
				}))
            end
			if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
				for i=1, #G.playing_cards do
					if G.playing_cards[i].ability.nyx_mirage then
						SMODS.destroy_cards { G.playing_cards[i] }
					end
				end
			end
        end
	end
}
SMODS.Blind {
	key = 'sum',
    loc_txt = {
        name = 'The Sum',
        text = {
          'Adds 100 to required',
		  'score every Hand',
		  'Scales with Ante'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 3},
	boss = { min = 3 },
	dollars = 5,
	mult = 2,
	boss_colour = HEX('4c56af'),
	calculate = function(self, blind, context)
        if not blind.disabled then
			if G.GAME.round_resets.ante < 5 then
				local sum_amt = 100 * (G.GAME.round_resets.ante - 2)
				G.GAME.blind.loc_debuff_lines[1] = 'Adds '..sum_amt..' to required'
			elseif G.GAME.round_resets.ante >= 5 then
				local sum_amt = G.GAME.blind.chips/10
				G.GAME.blind.loc_debuff_lines[1] = 'Adds '..sum_amt..' to required'
			end
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
						if G.GAME.round_resets.ante < 5 then
                        	G.GAME.blind.chips = G.GAME.blind.chips + (100 * (G.GAME.round_resets.ante - 2))
							G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						elseif G.GAME.round_resets.ante >= 5 then
							G.GAME.blind.chips = G.GAME.blind.chips + (G.GAME.blind.chips/10)
							G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						end
                        return true
                    end
                }))
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
SMODS.Blind {
	key = 'difference',
    loc_txt = {
        name = 'The Difference',
        text = {
          'Removes 100 from',
		  'score every Hand',
		  'Scales with Ante'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 4},
	boss = { min = 3 },
	dollars = 5,
	mult = 2,
	boss_colour = HEX('a03b3b'),
	calculate = function(self, blind, context)
        if not blind.disabled then
			if G.GAME.round_resets.ante < 5 then
				local diff_amt = (100 * (G.GAME.round_resets.ante - 2))
				G.GAME.blind.loc_debuff_lines[1] = 'Removes '..diff_amt..' from'
			elseif G.GAME.round_resets.ante >= 5 then
				local diff_amt = (G.GAME.blind.chips/10)
				G.GAME.blind.loc_debuff_lines[1] = 'Removes '..diff_amt..' from'
			end
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
						if G.GAME.round_resets.ante < 5 then
                        	G.GAME.chips = G.GAME.chips - (100 * (G.GAME.round_resets.ante - 2))
						elseif G.GAME.round_resets.ante >= 5 then
							G.GAME.chips = G.GAME.chips - (G.GAME.blind.chips/10)
						end
                        return true
                    end
                }))
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
SMODS.Blind {
	key = 'product',
    loc_txt = {
        name = 'The Product',
        text = {
          'Multiplies required score',
		  'by X1.5 every Hand'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 5},
	boss = { min = 6 },
	dollars = 5,
	mult = 1.5,
	boss_colour = HEX('7a7a7a'),
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips * 1.5
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        return true
                    end
                }))
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
SMODS.Blind {
	key = 'quotient',
    loc_txt = {
        name = 'The Quotient',
        text = {
          'Divides your score',
		  'by 1.5 every Hand'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 6},
	boss = { min = 6 },
	dollars = 5,
	mult = 1.5,
	boss_colour = HEX('161616'),
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        G.GAME.chips = G.GAME.chips / 1.5
                        return true
                    end
                }))
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
SMODS.Blind {
	key = 'robber',
    loc_txt = {
        name = 'The Robber',
        text = {
          'Steals 50% of your money',
		  'when you play a Hand'
        },
    },
	atlas = 'Blinds',
	pos = {x = 0, y = 7},
	boss = { min = 5 },
	dollars = 6,
	mult = 2,
	boss_colour = HEX('ffb707'),
	calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        local cash = G.GAME.dollars
						ease_dollars(cash * -0.5,true)
                        return true
                    end
                }))
                 blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
	end
}
--


-- Nyx bullshit --

local position = math.random(1,24)
local night = false
local eclipse = false
if position == 24 then
	position = 10
	eclipse = true
elseif position >= 21 then
	position = 9
	night = true
else
	position = 8
end
SMODS.Joker{
	key = 'frontcard',
    atlas = 'Jokers',
    unlocked = true,
    discovered = true,
	no_collection = true,
    pos = {x = position, y = 1},
	in_pool = function(self) 
		return false 
	end
}
SMODS.Sound({
	key = "music_cursed",
	path = "music_cursed.ogg",
	volume = 1.2,
	pitch = 1,
	select_music_track = function()
		return G.STAGE == G.STAGES.MAIN_MENU and (night or eclipse)
	end,
})

local game_main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
	G.C.COLORSS = HEX("be93d4")
	G.C.COLORSSTHESECOND = HEX("ffffff") -- Cum
	if night then
		G.C.COLORSS = HEX("0f0c29")
		G.C.COLORSSTHESECOND = HEX("302b63")
	elseif eclipse then
		G.C.COLORSS = HEX("000000")
		G.C.COLORSSTHESECOND = HEX("434343")
	end
	G.C.mid_flash = 0
	G.C.vort_time = 7
	G.C.vort_speed = 0.4
    local ret = game_main_menu_ref(self, change_context)

    local newcard = SMODS.create_card({key='j_nyx_frontcard', area = G.title_top, no_edition = true })
    self.title_top.T.w = self.title_top.T.w * 1.7675
	self.title_top.T.x = self.title_top.T.x - 0.8

	newcard.T.w = newcard.T.w * 1.1 * 1.2
	newcard.T.h = newcard.T.h * 1.1 * 1.2
	newcard.no_ui = true
	newcard.states.visible = false
	self.title_top:emplace(newcard)
	self.title_top:align_cards()

	G.SPLASH_BACK:define_draw_steps({
		{
			shader = "splash",
			send = {
				{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
				{name = 'vort_speed', val = G.C.vort_speed},
				{name = 'colour_1', ref_table = G.C, ref_value = 'COLORSS'},
				{name = 'colour_2', ref_table = G.C, ref_value = 'COLORSSTHESECOND'},
				{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
			},
		},
	})
	if change_context == "splash" then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			blockable = false,
			blocking = false,
			func = function()
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
				return true
			end,
		}))
	else
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0,
			blockable = false,
			blocking = false,
			func = function()
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
				return true
			end,
		}))
	end

	return ret
end
-- I have no idea how this all works but it does so dont question it
-- This is required for the Joker that multiplies other joker values
NYX = {
    C = {
        main =  HEX('6E3AA6'),
        secondary = HEX('a36be8'),
        credits = {
            Lucky6 = HEX('fa5eff'),
            canicao = HEX('4b4687'),
            canicao_text = HEX('b9af87'),
            uhadme = HEX('56a786')
        }
    },
	funcs = {
	--Given a `table_in` (value table or card object) and a config table, modifies the values in `table_in` depending 
	--- on the `config` provided. `config` accepts these values:
	--- * `add`
	--- * `multiply`
	--- * `keywords`: list of specific values to change in `table_in`. If nil, change every value in `table_in`.
	--- * `unkeywords`: list of specific values to *not* change in `table_in`.
	--- * `x_protect`: if true (or not set), any X effects (Xmult, Xchips, etc.) whose value is currently 1 are not modified. If false, this check is bypassed - which may result in some unlisted values being 
	--- modified.
	--- * `reference`: initial values for the provided table. If nil, defaults to `table_in`.
	--- 
	--- This function scans all sub-tables for numeric values, so it's recommended to pass the card's ability table rather than the entire card object.
	--- 
	--- SHUT THE FUCK UP VSCODE!
	---@diagnostic disable-next-line: undefined-doc-name
	---@param table_in table|Card
	---@param config table
	mod_card_values = function (table_in, config)
            if not config then config = {} end
            local add = config.add or 0
            local multiply = config.multiply or 1
            local keywords = config.keywords or {}
            local unkeyword = config.unkeywords or {}
            local x_protect = config.x_protect or true -- If true and a key starts with x_ and the value is 1, it won't multiply
            local reference = config.reference or table_in
            local function modify_values(table_in, ref)
                for k,v in pairs(table_in) do -- For key, value in the table
                    if type(v) == "number" then -- If it's a number
                        if (keywords[k] or (NYX.T.table_true_size(keywords) < 1)) and not unkeyword[k] then -- If it's in the keywords, OR there's no keywords and it isn't in the unkeywords
                            if ref and ref[k] then -- If it exists in the reference
                                if not (x_protect and (NYX.T.starts_with(k,"x_") or NYX.T.starts_with(k,"h_x_")) and ref[k] == 1) then
                                    table_in[k] = (ref[k] + add) * multiply -- Set it to (reference's value + add) * multiply
                                end
                            end
                        end
                    elseif type(v) == "table" then -- If it's a table
                        modify_values(v, ref[k]) -- Recurse for values in the table
                    end
                end
            end
            if table_in == nil then
                return
            end
            modify_values(table_in, reference)
        end,
	}
}
NYX.T = {}
---@param str string
---@param start string
---@return boolean
NYX.T.starts_with = function(str,start)
    return str:sub(1, #start) == start
end
---@param table table
---@param value any
---@return boolean
NYX.T.table_contains = function(table,value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end
---@param table table
---@return number
NYX.T.table_true_size = function(table)
    local n = 0
    for k,v in pairs(table) do
        n = n+1
    end
    return n
end
--


--various presets --

--[[ Joker thingy
SMODS.Joker{
	key = '',
    loc_txt = {
        name = '',
        text = {
          ''
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 1,
    cost = 0,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
	config = { 
		extra = {
			
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				
			}
		}
	end,
	calculate = function(self,card,context)
		if  then
		
		end
	end
}
]]

--[[ Delete card thingy
			G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards{ card }
					return true
				end
            })) 
]]
