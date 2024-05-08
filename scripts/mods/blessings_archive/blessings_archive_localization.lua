local mod = get_mod("blessings_archive")

mod:add_global_localize_strings({
    rarity_1 = {
        en = "Tier I",
        ru = "Уровень I",
        ["zh-cn"] = "一级",
    },
    rarity_2 = {
        en = "Tier II",
        ru = "Уровень II",
        ["zh-cn"] = "二级",
    },
    rarity_3 = {
        en = "Tier III",
        ru = "Уровень III",
        ["zh-cn"] = "三级",
    },
    rarity_4 = {
        en = "Tier IV",
        ru = "Уровень IV",
        ["zh-cn"] = "四级",
    },
    weapon_not_selected = {
        en = "Any weapon",
        ru = "Любое оружие",
        ["zh-cn"] = "任何武器",
    },
    rarity_not_selected = {
        en = "Any tier",
        ru = "Любой уровень",
        ["zh-cn"] = "任何等级",
    }
})

return {
	mod_title = {
		en = "Blessings Archive",
		ru = "Архив благословений",
		["zh-cn"] = "祝福档案",
	},
	open_blessings_archive = {
		en = "Open Blessings Archive",
		ru = "Открыть архив благословений",
		["zh-cn"] = "打开祝福档案",
	},
	mod_description = {
		en = "Displays all blessings that you have earned",
		ru = "Показывает все имеющиеся благословения",
		["zh-cn"] = "显示所有已经获取的祝福",
	},
	debug_mode = {
        en = "Debug Mode",
		ru = "Режим отладки",
		["zh-cn"] = "调试模式",
    },
	fits_weapon = {
		en = "Fits on:",
		ru = "Подходит к:",
		["zh-cn"] = "可用于：",
	},
	filters_title = {
        en = "Filters",
        ru = "Фильтры",
        ["zh-cn"] = "筛选",
    },
    shown_count = {
        en = "Shown: %s",
        ru = "Показано: %s",
        ["zh-cn"] = "显示： %s",
    },
    total_count = {
        en = "Total: %s/%s",
        ru = "Всего: %s/%s",
        ["zh-cn"] = "总数： %s/%s",
    },
    all_traits = {
        en = "All",
        ru = "Все"
    },
    seen_traits = {
        en = "Owned",
        ru = "Имеются"
    },
    unseen_traits = {
        en = "Missing",
        ru = "Отсутствуют"
    },
    -- Trait categories.
    bespoke_lasgun_p2 = {
        en = "Helbore Lasgun",
        ru = "Хелборский лазган",
        ["zh-cn"] = "地狱钻激光枪",
    },
    bespoke_combataxe_p3 = {
        en = "Shovel",
        ru = "Саперная лопата",
        ["zh-cn"] = "工兵铲",
    },
    bespoke_rippergun_p1 = {
        en = "Ripper Gun",
        ru = "Дробовик-потрошитель",
        ["zh-cn"] = "开膛枪",
    },
    bespoke_lasgun_p1 = {
        en = "Infantry Lasgun",
        ru = "Пехотный лазган",
        ["zh-cn"] = "步兵激光枪",
    },
    bespoke_thumper_p2 = {
        en = "Rumbler",
        ru = "Рамблер",
        ["zh-cn"] = "低吼者",
    },
    bespoke_chainsword_2h_p1 = {
        en = "Heavy Eviscerator",
        ru = "Тяжелый эвисцератор",
        ["zh-cn"] = "重型开膛剑",
    },
    bespoke_autopistol_p1 = {
        en = "Shredder Autopistol",
        ru = "Автопистолет-крошитель",
        ["zh-cn"] = "粉碎者自动手枪",
    },
    bespoke_forcestaff_p4 = {
        en = "Voidstrike Force Staff",
        ru = "Психосиловой пустотный посох",
        ["zh-cn"] = "虚空打击力场杖",
    },
    bespoke_ogryn_combatblade_p1 = {
        en = "Cleaver",
        ru = "Тесак",
        ["zh-cn"] = "砍刀",
    },
    bespoke_ogryn_heavystubber_p1 = {
        en = "Twin-Linked Heavy Stubber",
        ru = "Спаренный тяжелый пулемет",
        ["zh-cn"] = "双联重机枪",
    },
    bespoke_forcestaff_p3 = {
        en = "Surge Force Staff",
        ru = "Волновой психосиловой посох",
        ["zh-cn"] = "激涌力场杖",
    },
    bespoke_laspistol_p1 = {
        en = "Heavy Laspistol",
        ru = "Тяжелый лазпистолет",
        ["zh-cn"] = "重型激光手枪",
    },
    bespoke_powermaul_2h_p1 = {
        en = "Crusher",
        ru = "Дробитель",
        ["zh-cn"] = "粉碎者",
    },
    bespoke_autogun_p2 = {
        en = "Braced Autogun",
        ru = "Усиленный автомат",
        ["zh-cn"] = "稳固自动枪",
    },
    bespoke_combatsword_p2 = {
        en = "Heavy Sword",
        ru = "Тяжелый меч",
        ["zh-cn"] = "重剑",
    },
    bespoke_plasmagun_p1 = {
        en = "Plasma Gun",
        ru = "Плазмомёт",
        ["zh-cn"] = "等离子枪",
    },
    bespoke_stubrevolver_p1 = {
        en = "Quickdraw Stub Revolver",
        ru = "Скорострельный стаб-револьвер",
        ["zh-cn"] = "速发左轮枪",
    },
    bespoke_lasgun_p3 = {
        en = "Recon Lasgun",
        ru = "Разведывательный лазган",
        ["zh-cn"] = "侦察激光枪",
    },
    bespoke_combatsword_p1 = {
        en = "Catachan \"Devil's Claw\" Sword",
        ru = "Катачанский меч «Дьявольский коготь»",
        ["zh-cn"] = "卡塔昌剑“恶魔之爪”",
    },
    bespoke_ogryn_powermaul_p1 = {
        en = "Power Maul",
        ru = "Силовая булава",
        ["zh-cn"] = "动力锤",
    },
    bespoke_autogun_p3 = {
        en = "Headhunter Autogun",
        ru = "Автомат-головострел",
        ["zh-cn"] = "猎颅者自动枪",
    },
    bespoke_thunderhammer_2h_p1 = {
        en = "Thunder Hammer",
        ru = "Громовой молот",
        ["zh-cn"] = "雷霆锤",
    },
    bespoke_flamer_p1 = {
        en = "Purgation Flamer",
        ru = "Огнемет чистки",
        ["zh-cn"] = "火焰喷射器",
    },
    bespoke_combatsword_p3 = {
        en = "Maccabian Duelling Sword",
        ru = "Маккабианский дуэльный меч",
        ["zh-cn"] = "决斗剑",
    },
    bespoke_combataxe_p1 = {
        en = "Combat Axe",
        ru = "Боевой топор",
        ["zh-cn"] = "战斧",
    },
    bespoke_combataxe_p2 = {
        en = "Tactical Axe",
        ru = "Тактический топор",
        ["zh-cn"] = "战术斧",
    },
    bespoke_forcestaff_p2 = {
        en = "Purgatus Force Staff",
        ru = "Психосиловой посох очищения",
        ["zh-cn"] = "净化力场杖",
    },
    bespoke_combatknife_p1 = {
        en = "Catachan Combat Blade",
        ru = "Катачанский боевой клинок",
        ["zh-cn"] = "战斗利刃",
    },
    bespoke_forcesword_p1 = {
        en = "Blaze Force Sword",
        ru = "Огненный психосиловой меч",
        ["zh-cn"] = "力场剑",
    },
    bespoke_shotgun_p1 = {
        en = "Combat Shotgun",
        ru = "Боевой дробовик",
        ["zh-cn"] = "战斗霰弹枪",
    },
    bespoke_autogun_p1 = {
        en = "Infantry Autogun",
        ru = "Пехотный автомат",
        ["zh-cn"] = "步兵自动枪",
    },
    bespoke_forcestaff_p1 = {
        en = "Trauma Force Staff",
        ru = "Травматический психосиловой посох",
        ["zh-cn"] = "创伤力场杖",
    },
    bespoke_thumper_p1 = {
        en = "Kickback",
        ru = "Отбойник",
        ["zh-cn"] = "击退者",
    },
    bespoke_ogryn_slabshield_p1 = {
        en = "Battle Maul & Slab Shield",
        ru = "Боевая булава и щит Верзилы",
        ["zh-cn"] = "作战大锤与板砖大盾",
    },
    bespoke_bolter_p1 = {
        en = "Spearhead Boltgun",
        ru = "Пронзающий болтер",
        ["zh-cn"] = "爆矢枪",
    },
    bespoke_ogryn_gauntlet_p1 = {
        en = "Grenadier Gauntlet",
        ru = "Гренадерская перчатка",
        ["zh-cn"] = "掷弹兵臂铠",
    },
    bespoke_ogryn_club_p2 = {
        en = "Bully Club",
        ru = "Палица задиры",
        ["zh-cn"] = "恶霸棍棒",
    },
    bespoke_chainsword_p1 = {
        en = "Assault Chainsword",
        ru = "Штурмовой цепной",
        ["zh-cn"] = "突击链锯剑",
    },
    bespoke_chainaxe_p1 = {
        en = "Assault Chainaxe",
        ru = "Штурмовой цепной топор",
        ["zh-cn"] = "突击链锯斧",
    },
    bespoke_ogryn_club_p1 = {
        en = "Latrine Shovel",
        ru = "Малая саперная лопата",
        ["zh-cn"] = "公厕铲",
    },
    bespoke_powersword_p1 = {
        en = "Power Sword",
        ru = "Силовой меч",
        ["zh-cn"] = "动力剑",
    }
}
