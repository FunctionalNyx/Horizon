-- Bullshit code that should work but probably is very dumb

-- Genuinely Nyx I think we started a beautiful project and I really love seeing the DPG community come together for this with art
-- Like it genuinely warms my heart and I love working on this despite the pain in coding lmao - Bozo

-- i want to die - Nyx

local game_main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
	G.C.COLORSS = HEX("be93d4")
	G.C.COLORSSTHESECOND = HEX("ffffff")
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
		["j_diet_cola"] = true
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.Rarity {
	key = 'LostSoul',
	loc_txt = {
		name = 'Lost Souls',
		text = {
			'Cards that have been lost to time',
			'and space, only to be found again'
		}
	},
	default_weight = 0.5,
	badge_colour = HEX("87c1ff"),
	{
    	["Joker"] = true
	}
}
-- Jokers

-- Common --
SMODS.Joker{
    key = 'Joe',
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
		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				colour = G.C.MULT,
				chip_mod = card.ability.extra.chips,
				message = '-'..card.ability.extra.chips..' Chips',
				colour = G.C.CHIP,
				card = card
			}
		end
	end
}
SMODS.Joker{
    key = 'Eeffoc', --joker key
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
    key = 'Asto', --joker key
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
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end})) 
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
          '{C:green}#1# in 3{} Chance to',
		  'refund a {C:attention}purchase{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
	end
}
SMODS.Joker{
	key = 'printer',
    loc_txt = {
        name = 'Printer',
        text = {
          '{C:green}#1# in 4{} Chance to Generate a {C:attention}Consumable{}',
		  'when using a {C:attention}Consumable{}',
		  '{C:inactive,s:0.8}Does {}{C:red,s:0.8}NOT{}{C:inactive,s:0.8} need room{}'
        },
    },
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
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.current_tarot_planet)
                card:add_to_deck()
                G.consumeables:emplace(card)
            return true end }))
			delay(0.6)
		end
	end
}
SMODS.Joker{
	key = 'scratch',
    loc_txt = {
        name = 'Scratch Ticket',
        text = {
          '{C:green}#2# in #1#{} Chance to',
		  'give {C:money}$#3#{} every hand',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}astololofo{}'
        },
    },
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
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}astololofo{}'
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
		  '{C:attention}rank of destroyed cards{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
          'Gain {C:red}+1{} Discard',
		  'Able to discard {C:red}6{} cards',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
				center.ability.extra.limit
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
							return true; end})) 
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
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
		if context.ending_shop then
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_origin' then
					G.E_MANAGER:add_event(Event({
						func = function()
							other_joker.T.r = -0.2
							other_joker:juice_up(0.3, 0.4)
							other_joker.states.drag.is = true
							other_joker.children.center.pinch.x = true
							card.T.r = -0.2
							card:juice_up(0.3, 0.4)
							card.states.drag.is = true
							card.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
								func = function()
									G.jokers:remove_card(other_joker)
									G.jokers:remove_card(card)
									other_joker:remove()
									card:remove()
									other_joker = nil
									card = nil
								return true; end})) 
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
	key = 'Moist',
    loc_txt = {
        name = 'Moist',
        text = {
          '{C:green}#2# in #1#{} Chance to',
		  '{C:blue}Moisturize{} scoring cards',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
	pools = {
		["Horizonjokers"] = true, -- This needs to be here for it to work with the booster pack, if its legendary dont include this
		["DPGJokers"] = true
	}, 
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
			odds = 4
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
-- Uncommon --
SMODS.Joker{
	key = 'Dopi',
    loc_txt = {
        name = 'Dopi',
        text = {
          'Gains {X:mult,C:white}X#2#{} Mult every {C:attention}Joe{} Sold',
		  '{s:0.8}(Currently{} {X:mult,C:white,s:0.8}X#1#{} {s:0.8}Mult){}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_Joe
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
		if context.selling_card and (context.card.config.center.key == "j_nyx_Joe" or context.card.config.center.key == "j_nyx_joe2") then
			card.ability.extra.xMult = card.ability.extra.xMult + card.ability.extra.xMult_gain
			return {
				message = "Fuck you Joe",
				message_card = card
			}
		end
	end
}
SMODS.Joker{
    key = 'Neo', --joker key
    loc_txt = { -- local text
        name = '{C:purple,E:2}Ourpler{}',
        text = {
          '{C:purple,s:0.8}Ourpling{}',
		  'If the first {C:attention}hand{} has {C:attention}one card{}',
		  'Add a {C:purple}Purple Seal{} to it',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}kirb{}'
        },
    },
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
    key = 'Kirb', --joker key
    loc_txt = { -- local text
        name = 'Kirbos',
        text = {
          'Gives {C:mult}#1#{} Mult and {C:chips}#2#{} Chips',
		  'For every level the',
		  'played {C:attention}Poker{} {C:attention}hand{} has',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
	key = 'Bozo',
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
			if context.individual and #context.full_hand == 1 and context.cardarea == G.play then
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
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
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
		info_queue[#info_queue + 1] = G.P_CENTERS.j_nyx_Joe
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
						key = 'j_nyx_Joe',
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end})) 
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
                           G.jokers:remove_card(card)
                           card:remove()
                           card = nil
						return true; end})) 
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
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
        name = 'Best Friend', -- 
        text = {
          'Gives {C:mult}#3#{} Mult,',
		  'Gains {C:mult}+1{} Mult after every {C:attention}Blind{}',
		  'As your friend, he has a {C:green}#1# in 3{} chance to give {C:money}$#4#{},', -- money
		  'and {C:green}#1# in 6{} chance to create a {C:tarot}Tarot{} Card every hand played.',
		  '{C:inactive,s:0.7}snuggle... -w-{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
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
			odds = 1,
			mult = 4,
			money = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				(G.GAME and G.GAME.probabilities.normal or 1), 
				center.ability.extra.odds,
				center.ability.extra.mult,
				center.ability.extra.money
			}
		}
	end,
	calculate = function(self,hand,context)
		local dollarAmnt = 0
		if context.joker_main then
			if pseudorandom('nyx_friend') < G.GAME.probabilities.normal / 3 then
				dollarAmnt = hand.ability.extra.money
			end
			if pseudorandom('nyx_friend2') < G.GAME.probabilities.normal / 6 then
				return {
					message = 'My gift to you <3',
					colour = G.C.PURPLE,
					mult = hand.ability.extra.mult,
					card = hand
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
					mult = hand.ability.extra.mult,
					card = hand
				}
			else
				return {
					mult = hand.ability.extra.mult,
					card = hand,
				}
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			hand.ability.extra.mult = hand.ability.extra.mult + 1
			return {
				message = '+1 Mult',
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
		  '{C:inactive,s:0.8}Currently{} {X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
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
		  '{C:attention}last{} scored cards towards {C:attention}8{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}',
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
			'{C:red,s:0.8}Will destroy its own duplicates{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
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

local randomWords = {'Jo  ker', 'unde fined    ', 'broken', 'SJKFSUQ   ', '   FunctionalNyx', 'ER  ROR', '-face', 'Plac   eholder', 'Misprint  ', 'MESSAGE   ', 'UNK   NOWN', '34   213551', 'meani   ng', 'TRU  E', 'FAL  SE', 'Gi  ves', 'bozo!'}
local colors = {G.C.RED, G.C.GREEN, G.C.BLUE, G.C.YELLOW, G.C.PURPLE, G.C.ORANGE, G.C.PINK, G.C.BROWN}
local suits = {'Spades', 'Hearts', 'Diamonds', 'Clubs'}
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'}
local rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}

SMODS.Joker{ -- This joker should be referred to as "ERROR"
	key = 'err',
    loc_txt = {
        name = '#5#',
        text = {
			'When {X:chips,C:mult}#1#{}',
			'#2# {X:chips,C:purple}Blind{} {X:purple,C:inactive}#3#{} {C:mult}mult{} after',
			'every {X:mult,C:white}#4#{}',
			'{C:inactive,s:0.8}Art by {}{X:chips,C:white,s:0.8}#2#{}'
        },
    },
	pools = {["ModJonklers"] = true,["Horizonjokers"] = true},
    atlas = 'Jokers',
    rarity = 2,
    cost = 1, -- why were u 20 dollars
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
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

		if context.individual and context.cardarea == G.play then
			for i=1, #context.scoring_hand do
				-- Randomize rank
				if pseudorandom('nyx_error') < G.GAME.probabilities.normal / 20 then
					G.E_MANAGER:add_event(Event({
						func = function()
							assert(SMODS.change_base(context.scoring_hand[i], nil, ranks[math.random(1, #ranks)]))
							return true
						end
					}))
				end

				-- Randomize suit
				if pseudorandom('nyx_error2') < G.GAME.probabilities.normal / 20 then
					G.E_MANAGER:add_event(Event({
						func = function()
							assert(SMODS.change_base(context.scoring_hand[i], suits[math.random(1, #suits)], nil))
							return true
						end
					}))
				end
			end
		end

		if context.joker_main then
			-- Chance to replace jokers
			for i=1, #G.jokers.cards do -- for all jokers
				if G.jokers.cards[i] ~= card then -- not itself
					local other_joker = G.jokers.cards[i]

					-- Don't replace joker if it is another ERROR or is oops all 6s
					if other_joker.config.center.key ~= "j_nyx_err" and other_joker.config.center.key ~= "j_oops" then
						-- Retain edtion, don't replace eternals
						if pseudorandom('nyx_error3') < G.GAME.probabilities.normal / 15 then
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
						end
					end
				end
			end

			return {
				mult = math.random(-6, 10),
				chips = math.random(-12, 20),
				Xmult = math.random(70, 124)/100
			}
		end

		if context.end_of_round and context.cardarea == G.jokers then
			return {
				dollars = math.random(-5, 6),
			}
		end
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
          '{X:mult,C:white}X#1#{} Mult if you have no cards held in hand',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
		  '{C:inactive,s:0.8}Does not reroll editions, enhancements, or seals{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Nyx{}'
        },
    },
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
	config = {

	},
	calculate = function(self,card,context)
		if context.reroll_shop and context.cardarea == G.jokers then
			for i = 1, #G.jokers.cards do
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
	pools = {["Horizonjokers"] = true},
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
-- Rare --
SMODS.Joker{
    key = 'AEOM', --joker key
    loc_txt = { -- local text
        name = 'All Eyes On Me',
        text = {
          'All {C:attention}face{} Cards',
          'Grant {X:mult,C:white}X#1#{} Mult',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Nyx{}'
        },
    },
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
			Xmult = 1.25,
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
    key = 'Nicky', --joker key
    loc_txt = { -- local text
        name = 'The Nickle Monster',
        text = {
          'Either {X:mult,C:white}XMult{} of {X:mult,C:white}50{} or {X:mult,C:white}0.02{}',
		  '{C:inactive,s:0.8}Not Compatible with {}{C:green,s:0.8}Oops All 6s{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
    key = 'Straz', --joker key
    loc_txt = { -- local text
        name = '{C:red}Beastmode{}',
        text = {
          'There can only be {C:red}one{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
			if other_joker.config.center.key == 'j_nyx_Straz' and other_joker ~= card then
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
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end})) 
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
		  'give {X:mult,C:white}X#1#{} Mult',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
									extra = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Ramen" then
							NYX.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = card.ability.extra.multiplier,
								x_protect = true,
								unkeywords = {
									Xmult = true
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
									every = true
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
									h_mod = true
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
									increase = true
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
							_card.T.r = -0.2
							_card:juice_up(0.3, 0.4)
							_card.states.drag.is = true
							_card.children.center.pinch.x = true
							-- This part destroys the card.
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blockable = false,
								func = function()
									G.jokers:remove_card(_card)
									_card:remove()
									_card = nil
									return true;
								end
							}))
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
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
			if card.ability.extra.count >= 5 and math.random(1, 3) == 1 then
				play_sound('timpani', 0.5)
				return {
					card:juice_up(0.3, 0.5),
					G.jokers:remove_card(card),
					card:remove(),
					card = nil,
					SMODS.add_card {
						set = 'Joker',
						legendary = true,
						area = G.jokers
					},
					message = "Ascended!"
				}
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
-- Legendary --
SMODS.Joker{
	key = 'plaguebearer',
    loc_txt = {
        name = 'Plague Bearer',
        text = {
          'All {C:attention}Diseased{} cards give {X:mult,C:white}X#1#{}',
		  '{C:attention}Evolves{} when all cards are {C:attention}Diseased{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Nyx{}'
        },
    },
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
							return true; end})) 
						return true
					end
				})) 
				return {
					message = "Evolved!",
					colour = G.C.GREEN,
					SMODS.add_card {
						key = "j_nyx_pestilence"
					}
				}
			end
		end
	end
}
SMODS.Joker{
    key = 'Sybyrr', --joker key
    loc_txt = { -- local text
        name = 'Sybyrrrrrr',
        text = {
          'Gains {X:mult,C:white}X#1#{} Mult for every {C:attention}$1{} you have',
		  'All {C:attention}Jokers{} give {C:attention}#2#${}',
		  '{C:inactive,s:0.8}(Currently{} {X:mult,C:white,s:0.8}X#3#{} Mult){}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'

        },
    },
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
    key = 'Pyro',
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
-- LOST SOULS --
SMODS.Joker{
	key = 'fate',
    loc_txt = {
        name = 'FATE',
        text = {
        	'Copies the effects of all other Jokers',
			'{C:inactive,s:0.8}Does not copy {}{C:attention,s:0.8}Blueprint, Brainstorm, {}{C:inactive,s:0.8}or{} {C:attention,s:0.8}FATE{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}bozo!{}'
        },
    },
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
				
				if (other_joker.config.center.key ~= "j_blueprint" and other_joker.config.center.key ~= "j_nyx_fate" and other_joker.config.center.key ~= "j_brainstorm") then
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
		  'All {C:attention}Diseased{} cards {C:attention}retrigger{}',
		  '{C:attention}Diseased{} cards no longer {C:red}decay{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Nyx{}'
        },
    },
	pools = {
		["ModJonklers"] = true
	},
	in_pool = function(self)
		return false 
	end,
    atlas = 'Jokers',
    rarity = 'nyx_LostSoul',
    cost = 18,
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
		  '{C:inactive,s:0.8}Currently{} {X:mult,C:white,s:0.8}X#1#{} {C:inactive,s:0.8}Mult{}',
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Nyx{}'
        },
    },
	pools = {
		["ModJonklers"] = true
	},
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 10,
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
		  '{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        },
    },
	pools = {
		["ModJonklers"] = true
	},
    atlas = 'Jokers',
    rarity = "nyx_LostSoul",
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 8, y = 2},
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

-- unfinished jokers below--
-- unfinished jokers below--
-- unfinished jokers below--

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
	key = 'integer',
    loc_txt = {
        name = 'Integer',
        text = {
          'All {C:attention}Non-Face{} cards',
		  'Give {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 2, y = 0},
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
-- Uncommon --
SMODS.Joker{
	key = 'allinred',
    loc_txt = {
        name = '{C:red,E:1}All In{}',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  'Never see a {C:attention}shop{} again'
        },
    },
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
			Xmult = 5,
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
		  'Hand {C:attention}size{} is set to 1'
        },
    },
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
			Xmult = 4, -- Logger
			hand_size = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.hand_size
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
	end
}
SMODS.Joker{
	key = 'allingreen',
    loc_txt = {
        name = '{C:green,E:1}All In{}',
        text = {
          '{X:mult,C:white}X#1#{} Mult',
		  'Joker {C:attention}slots{} are set to 1'
        },
    },
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
			Xmult = 7,
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
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots - 1
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
		  '{C:red}There is no shop{}',
		  '{C:red}There is only one hand{}',
		  '{C:red}Only one card{}',
		  '{C:red}Only one Joker{}'
        },
    },
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
			count = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return{
			vars = {
				center.ability.extra.Xmult,
				center.ability.extra.hand_size,
				center.ability.extra.joker_slots,
				center.ability.extra.count
			}
		}
	end,
	add_to_deck = function(self, card, from_debuff)
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
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots - 1
		G.hand:change_size(card.ability.extra.hand_size - 1)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
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
	key = 'gummies',
    loc_txt = {
        name = 'Vitamin Gummies',
        text = {
          '{X:mult,C:white}X#1#{} Mult but decreases by {X:mult,C:white}X0.25{} every hand',
		  "{C:inactive,E:1,s:0.8}You know you're only supposed to eat 2 a day right?{}"
        },
    },
	pools = {
		["Horizonjokers"] = true,
		["FoodJokers"] = true
	},
    atlas = 'Placeholder',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pos = {x = 3, y = 0},
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
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
							return true; end})) 
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
	key = 'Aurafarm',
    loc_txt = {
        name = 'Aura Farm',
        text = {
          '{C:green}#1# in #2#{} chance for each played {C:attention}Ace{}',
		  'to create an {C:spectral}Aura{} card when scored',
		  '{C:inactive,s:0.8}(Must have room){}'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 0},
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
	key = 'journey',
    loc_txt = {
        name = 'The Journey',
        text = {
          'All {C:attention}Non-face{} cards',
		  '{C:attention}retrigger #1#{} time when scored'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 2,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 0},
	config = { 
		extra = {
			retrigger = 1
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
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0) or
                (context.other_card:get_id() == 14) then
                return {
                    repetitions = card.ability.extra.retrigger
                }
            end
        end
	end
}
-- Rare --
SMODS.Joker{
	key = 'fresh_start',
    loc_txt = {
        name = 'Fresh Start',
        text = {
          'All {C:attention}Odd{} cards',
		  'Give {X:mult,C:white}X#1#{} Mult when scored'
        },
    },
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
		  'Give {X:mult,C:white}X#1#{} Mult when scored'
        },
    },
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
		if context.ending_shop then
			for i = 1, #G.jokers.cards do
				local other_joker = G.jokers.cards[i]
				if other_joker.config.center.key == 'j_nyx_fresh_start' then
					G.E_MANAGER:add_event(Event({
						func = function()
							other_joker.T.r = -0.2
							other_joker:juice_up(0.3, 0.4)
							other_joker.states.drag.is = true
							other_joker.children.center.pinch.x = true
							card.T.r = -0.2
							card:juice_up(0.3, 0.4)
							card.states.drag.is = true
							card.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
								func = function()
									G.jokers:remove_card(other_joker)
									G.jokers:remove_card(card)
									other_joker:remove()
									card:remove()
									other_joker = nil
									card = nil
								return true; end})) 
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
	key = 'Mathboy',
    loc_txt = {
        name = 'Mathematician',
        text = {
          '{C:attention}Copies{} all {E:2,C:dark_edition}Math{} Jokers'
        },
    },
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
	calculate = function(self,card,context)
		local effects = {}
		for i=1, #G.jokers.cards do -- for all jokers
			if G.jokers.cards[i] ~= card then -- not itself
				local other_joker = G.jokers.cards[i]
				-- PREPARE THYSELF! NYX COOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOODE! I did this at midnight leave me alone im tired and none of this makes sense
				if (other_joker.config.center.key == 'j_fibionacci' or other_joker.config.center.key == 'j_even_steven' or other_joker.config.center.key == 'j_odd_todd') or
				(other_joker.config.center.key == 'j_nyx_end' or other_joker.config.center.key == 'j_nyx_origin' or other_joker.config.center.key == 'j_nyx_phi') or
				(other_joker.config.center.key == 'j_nyx_nerd' or other_joker.config.center.key == 'j_nyx_fresh_start' or other_joker.config.center.key == 'j_nyx_familiar_end') or
				(other_joker.config.center.key == 'j_nyx_integer' or other_joker.config.center.key == 'j_nyx_journey' or other_joker.config.center.key == 'j_nyx_lasting_adventure') then
					local effect = SMODS.blueprint_effect(card, other_joker, context) -- get effect
					if effect then
						table.insert(effects, effect) -- add to array
					end
				end
			end
		end
		return SMODS.merge_effects(effects) -- Do
	end
}
-- Legendary --
SMODS.Joker{
	key = 'lasting_adventure',
    loc_txt = {
        name = 'Lasting Adventure',
        text = {
          'All {C:attention}Non-face{} cards',
		  'Give {X:mult,C:white}X#1#{} Mult when scored'
        },
    },
	pools = {
		["Horizonjokers"] = true -- This needs to be here for it to work with the booster pack, if its legendary dont include this
	}, 
    atlas = 'Placeholder',
    rarity = 4,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 0},
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
            if (context.other_card:get_id() <= 10 and
                    context.other_card:get_id() >= 0) or
                (context.other_card:get_id() == 14) then
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
	end
}
-- LOST SOULS --
SMODS.Joker{
	key = '@everyone',
    loc_txt = {
        name = '{X:chips,C:white}@everyone{}',
        text = {
          '{C:inactive,s:1.2,E:2}[11:43 PM]{} {C:green,s:1.2,E:2}Juic+e [131/150]{}{C:inactive,s:1.2,E:2}:{} {s:1.2,E:2}Oops{}'
        },
    },
    atlas = 'Placeholder',
    rarity = 'nyx_LostSoul',
    cost = 15,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 5, y = 0},
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
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
						return true; end})) 
					return true
				end
            })) 
		end
	end
}
--


--- Other Stuff ---
-- Tarot --
SMODS.Atlas{
    key = 'Tarot', --atlas key
    path = 'Tarots.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
}
SMODS.Consumable{
    key = 'Weakness', --key
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
    key = 'plague',
    set = 'Tarot',
	atlas = 'Tarot',
    pos = { x = 1, y = 0 },
	loc_txt = {
		name = 'Plague',
		text = {
			'Convert {C:attention}1{} card into',
			'a {C:attention}Diseased{} card',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
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
SMODS.Consumable {
    key = 'Transmission',
    set = 'Tarot',
	atlas = 'Placeholder',
    pos = { x = 0, y = 0 },
	loc_txt = {
		name = 'Transmission',
		text = {
			'Tranfer {C:attention}everything{} but rank and suit',
			'From the {C:attention}right{} card to the {C:attention}left{} card',
			'{C:red}Destroys the right card{}'
		}
	},
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
    config = { extra = { seal = 'nyx_greenseal' }, max_highlighted = 1 },
	loc_txt = {
        name = 'Horizon', --name of card
        text = { --text of card
            'Add a {C:green}Green Seal{}',
			'to {C:attention}1{} selected',
			'card in your hand',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Nyx{}'
        }
    },
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
    key = 'blessing',
    set = 'Spectral',
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
			'{C:inactive,s:0.8}this card will not be consumed{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
        return #G.jokers.highlighted
    end
}
SMODS.Consumable {
    key = 'ritual',
    set = 'Spectral',
	atlas = 'Spectral',
    pos = { x = 4, y = 0 },
	loc_txt = {
        name = 'Ritual', --name of card
        text = { --text of card
            'Destroy a random {C:attention}Joker{}',
			'Add {C:dark_edition}Negative{} to',
			'random {C:attention}Joker{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
    end
}
SMODS.Consumable {
    key = 'curse',
    set = 'Spectral',
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
			'to a selected joker',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
        return #G.jokers.highlighted
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
			'Convert {C:attention}#1#{} cards into',
			'{C:attention}Frozen{} cards',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	cost = 4,
	unlocked = true,
	discovered = false,
	hidden = true,
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
    key = 'divine',
    set = 'Spectral',
	atlas = 'Placeholder',
    pos = { x = 1, y = 0 },
	loc_txt = {
		name = 'Divine',
		text = {
			'Convert {C:attention}#1#{} card into',
			'a {C:attention}True Lucky{} card'
		}
	},
	cost = 6,
	unlocked = true,
	discovered = false,
	hidden = true,
    config = { max_highlighted = 1, mod_conv = 'm_nyx_truelucky' },
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
			'From the {C:attention,E:2}Horizon{} Mod',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
			'From the {C:attention,E:2}Horizon{} Mod',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
			'From the {C:attention,E:2}Horizon{} Mod',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
			'From the {C:attention,E:2}Horizon{} Mod',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
			'From {C:attention,E:2}Dark Pyro Gaming{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
        }
    },
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
			'{C:attention}Mega Horizon Pack.{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
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
			'{C:attention}DPG Pack.{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
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
			'Start the game with a {C:attention}Milk Mann{}',
			'And an {C:green}Oops all 6s{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
    discovered = false,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card {
						key = 'j_nyx_milkmann',
						stickers = { "eternal" }
					}
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
    discovered = false,
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
					for i = 1, 4 do
						SMODS.add_card {
							key = 'j_oops',
							stickers = { "eternal"},
							edition = "e_negative"
						}
					end
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
			'All {C:attention}playing{} cards are {C:attention}enhanced{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
    discovered = false,
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
				for i=1, #G.playing_cards do
					local percent = 1.15 - (i-0.999)/(#G.playing_cards-0.998)*0.3
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.playing_cards[i]:flip();play_sound('card1', percent);G.playing_cards[i]:juice_up(0.3, 0.3);return true end }))
				end
					delay(0.2)
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
				for i=1, #G.playing_cards do
					if not SMODS.has_enhancement(G.playing_cards[i]) then
						G.playing_cards[i]:set_ability(G.P_CENTERS[enhancements[math.random(1, #enhancements)]])
					end
				end
				for i=1, #G.playing_cards do
					local percent = 0.85 + (i-0.999)/(#G.playing_cards-0.998)*0.3
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.playing_cards[i]:flip();play_sound('tarot2', percent, 0.6);G.playing_cards[i]:juice_up(0.3, 0.3);return true end }))
				end
				delay(0.5)
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
			'{C:green}#2# in #1#{} chance to {C:red}Decay{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
	discovered = false,
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
			'{C:attention}retriggering #3#{} times',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
	discovered = false,
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
	unlocked = true,
	discovered = false,
	config = {
		extra = {
			odds1 = 2,
			odds2 = 3,
			odds3 = 4,
			odds4 = 5,
			odds5 = 6,
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
			'Gains {C:chips}#2#{} Chips when played',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
	discovered = false,
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
			'will be {C:green}Moisturized{}',
			'',
			'{C:green}#2# in #1#{} chance to {C:red}Dry{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
	discovered = false,
	config = {
		extra = {
			odds = 5
		}
	},
	loc_vars = function(self,info_queue,center)
		info_queue[#info_queue + 1] = G.P_CENTERS['m_nyx_dry']
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
			if index and context.scoring_hand[index - 1] then
				local right_card = context.scoring_hand[index - 1]
				if right_card then
					if not SMODS.has_enhancement(right_card, 'm_nyx_wet') then
						right_card:set_ability(G.P_CENTERS.m_nyx_wet)
						return {
							juice_card = right_card
						}
					end
				end
			end
		end
		if context.destroy_card and context.cardarea == G.play and context.destroy_card == card then
			if pseudorandom('nyx_wet') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
			'{C:red}Very Brittle{}',
			'{C:inactive,s:0.8}Art by {}{C:green,s:0.8}Milk Mann{}'
		}
	},
	unlocked = true,
	discovered = false,
	config = {
		extra = {
			chips = -10,
			odds = 3
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
			if pseudorandom('nyx_dry') < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					message = "Neglected",
					message_card = card,
					remove = true
				}
			end
    	end
	end
}
-- 

-- Nyx bullshit --
SMODS.Joker{
	key = 'frontcard',
    atlas = 'Jokers',
    unlocked = true,
    discovered = true,
	no_collection =  true,
    pos = {x = 8, y = 1},
	in_pool = function(self) 
		return false 
	end
}
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
                        if (keywords[k] or (NYX.REND.table_true_size(keywords) < 1)) and not unkeyword[k] then -- If it's in the keywords, OR there's no keywords and it isn't in the unkeywords
                            if ref and ref[k] then -- If it exists in the reference
                                if not (x_protect and (NYX.REND.starts_with(k,"x_") or NYX.REND.starts_with(k,"h_x_")) and ref[k] == 1) then
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
NYX.REND = {}
---@param str string
---@param start string
---@return boolean
NYX.REND.starts_with = function(str,start)
    return str:sub(1, #start) == start
end
---@param table table
---@param value any
---@return boolean
NYX.REND.table_contains = function(table,value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end
---@param table table
---@return number
NYX.REND.table_true_size = function(table)
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
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
						return true; end})) 
					return true
				end
            })) 
]]
