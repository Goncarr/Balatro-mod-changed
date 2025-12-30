--- STEAMODDED HEADER
--- MOD_NAME: Simple
--- MOD_ID: SimpleJoker
--- MOD_AUTHOR: [Gon, Wolfy_Stacy, Richard_Nixon]
--- MOD_DESCRIPTION: An example mod on how to create Jokers.
--- PREFIX: xmpl
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas{
    key = 'Simple', 
    path = 'Jokers.png', 
    px = 71, 
    py = 95 
}
SMODS.Joker{
    key = 'Simpleton',
    loc_txt = { 
        name = 'Simple Joker',
        text = {
          'When Blind is selected,',
          'create a {C:attention}Joker{}',
          '{X:mult,C:white}X#1#{} Mult',
          'Gain {C:money}123${} at end of round'
        },
    },
    atlas = 'Simple',
    rarity = 1,

    cost = 1, 
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
      extra = {
        Xmult = 100
      }
    },
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.j_joker
        return {vars = {center.ability.extra.Xmult}}
    end,

    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end

        if context.setting_blind then
            local new_card = create_card('Joker', G.jokers, nil,nil,nil,nil,'j_joker')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,
    calc_dollar_bonus = function(self,card)
        return 123
    end,
}

-- jack of all jokers Jokers
SMODS.Atlas{
    key = 'jack_of_all_jokers',
    path = 'Unknown.png',
    px = 71,
    py = 95
}
SMODS.Joker{
    key = 'Jack_of_all_jokers',
    loc_txt = {
        name = 'Jack of All Jokers',
        text = {
          'When boos blind is defeated,',
          'create one {C:attention}Joker{}',
          '{C:attention}1 in 6{} chance to destroy',
          'cards next to it',
        },

    },
    atlas = 'jack_of_all_jokers',
    rarity = 3, 

    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
      extra = {
        Xmult = 100
      }
    },
    calculate = function(self,card,context)
        if context.main_eval and context.beat_boss then
            local current_jokers = #G.jokers.cards
            local jokers_to_add = 1
            local jokers = {}
            if type(G.P_JOKERS) == "table" then
                for key, joker in pairs(G.P_JOKERS) do
                    table.insert(jokers, key)
                end
            end
            if  G.jokers.config.card_limit >= current_jokers + jokers_to_add then
                    local random_key = jokers[math.random(#jokers)]
                    local new_card = create_card('Joker', G.jokers, nil,nil,nil,nil,random_key)
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
            end
    end

end
}


-- 21 kid joker
SMODS.Sound{
    key = '21',
    path = '21.ogg'
}

SMODS.Atlas{
    key = '21_kid',
    path = '21_kid.png',
    px = 71,
    py = 95
}


SMODS.Joker{
    key = '21_kid',
    
    loc_txt = {
        name = 'The Mathematician',
        text = {
            '{X:mult,C:white}2.1{} Mult if hand',
            'contains a 9 and 10'
        },
    },
    
    atlas = '21_kid',
    rarity = 2,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = {x = 0, y = 0},
    config = { 
      extra = {
        xmult = 2.1
      }
    },

calculate = function(self,card,context)
    if context.joker_main then
        local found_9, found_10 = false, false
        for _, c in ipairs(G.hand.cards) do
            if c:get_id() == 9 then found_9 = true end
            if c:get_id() == 10 then found_10 = true end
        end
        if found_9 and found_10 then
            return {
                card = card,
                xmult = card.ability.extra.xmult,
                message = 'X' .. card.ability.extra.xmult,
                colour = G.C.MULT,
                sound = 'xmpl_21'
            }
        end
    end
end
}

-- Gambler joker
SMODS.Atlas{
    key = 'The Gambler',
    path = 'gambling.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'The gambler',
    loc_txt = {
        name = 'The gambler',
        text = {
            'When blind is selected,',
            'Win or lose between {C:money}1 and 10${}'
        }
    },
    atlas = 'The Gambler',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    

    calculate = function(self,card,context)
        if context.setting_blind then
            local amount = math.random(0,10)
            if math.random() <= 5 then
                return{
                    card = card,
                    dollars = -amount,
                    message = '-$' .. amount,
                    color = G.C.RED

                }
            else
                return{
                    card = card,
                    dollars = amount,
                    message = '+$' .. amount,
                    color = G.C.MONEY

                }
            end
        end
    end
}


-- sad boy joker
SMODS.Atlas{
    key = 'Bedtime Joker',
    path = 'BedtimeJoker.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'Bedtime Joker',
    loc_txt = {
        name = 'Bedtime Joker',
        text = {
            'Game closes if players time',
            'equals to midnight'
        }
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    atlas = 'Bedtime Joker',
    pos = {x = 0, y = 0},
    

    calculate = function(self,card,context)
        local hour = os.date("%H")
        local min = os.date("%M")
        if hour == "00" and min == "00" then
            os.exit()
        end
    end
}

--Double Down joker
SMODS.Atlas{
    key = 'Double Down',
    px = 71,
    py = 95,
    path = 'DoubleDown.png'
}

SMODS.Joker{
    key = "Double Down",
        loc_txt = {
        name = 'Double Down',
        text = {
            'Receive a copy from the,',
            'last Tarot or Planer card,',
            'from a booster pack.'
        }
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    atlas = 'Double Down',
    pos = {x = 0, y = 0},

    calculate = function(self, card, context)  
        if context.ending_booster then
                    local last = G.GAME.last_tarot_planet  
                    if last and last ~= "" then
                        SMODS.add_card({ type = 'tarots', key = last })
                        return{
                            card = card,
                            message = 'Doubled!'
                        }
                        end
                end
    end
}


SMODS.Atlas{
    key = 'Voucher Joker',
    px = 71,
    py = 95,
    path = 'voucherJoker.png'
}

SMODS.Joker{
    key = "Voucher Joker",
        loc_txt = {
        name = 'Voucher Joker',
        text = {
            'For every voucher puchased,',
            'Multiplier increases by 10,',
            'current multiplier {C:mult}+#1#{} Mult.'
        }
    },
    config = { 
      extra = {
        mult = 0
      }
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    atlas = 'Voucher Joker',
    pos = {x = 0, y = 0},

    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.j_joker
        return {vars = {center.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)  
        if context.joker_main then
            return {
                card = card,
                mult = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult .. 'mult',
                colour = G.C.MULT
            }
        end

        if context.buying_card and context.card.ability.set == 'Voucher' then
            card.ability.extra.mult = card.ability.extra.mult + 10
            return{
                card = card,
                message = '+' .. '10' .. 'mult',
                colour = G.C.MULT
            }
        end
    end
}


------------------------------------------------BLINDS------------------------------

-- the cutter blind
SMODS.Atlas {
    key = "the_cutter",
    path = "checker.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = 'ANIMATION_ATLAS',
}

SMODS.Blind {
    key = "the_cutter",
    atlas = "the_cutter",
    pos = { x = 0, y = 0 },
    dollars = 10,
    discovered = true,
    mult = 5,
    boss = { min = 1},
    boss_colour = HEX('00008B'),    
    
    loc_txt = {
        name = 'The Cutter',
        text = {
            'cards on hand cut by half'
        },
    },


}

-- The paradox BLind
SMODS.Atlas {
    key = "paradox",
    path = "paradox.png",
    px = 34,
    py = 34,
    frames = 21,
    atlas_table = 'ANIMATION_ATLAS',
}

SMODS.Blind {
    key = "paradox",
    atlas = "paradox",
    pos = { x = 0, y = 0 },
    dollars = 5,
    discovered = true,
    mult = 5,
    boss = { min = 1},
    boss_colour = HEX('a6a6a6'),    
    
    loc_txt = {
        name = 'The Paradox',
        text = {
            'If blind is lost,',
            'return to ante 1.'
        },
    },


}

