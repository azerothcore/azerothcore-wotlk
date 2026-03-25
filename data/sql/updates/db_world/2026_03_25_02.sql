-- DB update 2026_03_25_01 -> 2026_03_25_02
--
-- Fix: Repopulate CreatureImmunitiesId for all creatures that had mechanic/school immune masks
-- The original migration (2026_03_22_03) ran the UPDATE before creature_immunities rows existed,
-- resulting in all creatures getting CreatureImmunitiesId=0
--

DELETE FROM `creature_immunities` WHERE `ID` IN (1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(1972, 0, 0, 2, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2'),
(1973, 0, 0, 4, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4'),
(1974, 0, 0, 16, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16'),
(1975, 0, 0, 18, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 18'),
(1976, 0, 0, 34, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 34'),
(1977, 0, 0, 40, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 40'),
(1978, 0, 0, 42, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 42'),
(1979, 0, 0, 64, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 64'),
(1980, 0, 0, 512, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 512'),
(1981, 0, 0, 514, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 514'),
(1982, 0, 0, 1024, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1024'),
(1983, 0, 0, 1056, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1056'),
(1984, 0, 0, 1058, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1058'),
(1985, 0, 0, 2048, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2048'),
(1986, 0, 0, 2050, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2050'),
(1987, 0, 0, 2052, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2052'),
(1988, 0, 0, 2080, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2080'),
(1989, 0, 0, 2082, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2082'),
(1990, 0, 0, 2178, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2178'),
(1991, 0, 0, 2192, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2192'),
(1992, 0, 0, 2208, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2208'),
(1993, 0, 0, 2210, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2210'),
(1994, 0, 0, 2562, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2562'),
(1995, 0, 0, 3074, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 3074'),
(1996, 0, 0, 4098, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4098'),
(1997, 0, 0, 4114, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4114'),
(1998, 0, 0, 4128, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4128'),
(1999, 0, 0, 4608, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4608'),
(2000, 0, 0, 4624, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4624'),
(2001, 0, 0, 6178, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 6178'),
(2002, 0, 0, 6810, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 6810'),
(2003, 0, 0, 8192, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 8192'),
(2004, 0, 0, 8224, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 8224'),
(2005, 0, 0, 12584, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 12584'),
(2006, 0, 0, 14374, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 14374'),
(2007, 0, 0, 14982, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 14982'),
(2008, 0, 0, 16384, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16384'),
(2009, 0, 0, 20516, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 20516'),
(2010, 0, 0, 21114, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 21114'),
(2011, 0, 0, 32768, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 32768'),
(2012, 0, 0, 65278, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 65278'),
(2013, 0, 0, 131072, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 131072'),
(2014, 0, 0, 131074, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 131074'),
(2015, 0, 0, 131106, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 131106'),
(2016, 0, 0, 132128, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 132128'),
(2017, 0, 0, 133122, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 133122'),
(2018, 0, 0, 133248, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 133248'),
(2019, 0, 0, 133250, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 133250'),
(2020, 0, 0, 139264, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 139264'),
(2021, 0, 0, 139298, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 139298');

DELETE FROM `creature_immunities` WHERE `ID` IN (2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040,2041,2042,2043,2044,2045,2046,2047,2048,2049,2050,2051,2052,2053,2054,2055,2056,2057,2058,2059,2060,2061,2062,2063,2064,2065,2066,2067,2068,2069,2070,2071);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2022, 0, 0, 141440, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 141440'),
(2023, 0, 0, 143360, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 143360'),
(2024, 0, 0, 143396, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 143396'),
(2025, 0, 0, 262144, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 262144'),
(2026, 0, 0, 262146, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 262146'),
(2027, 0, 0, 262172, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 262172'),
(2028, 0, 0, 263222, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 263222'),
(2029, 0, 0, 265792, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 265792'),
(2030, 0, 0, 274592, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 274592'),
(2031, 0, 0, 278534, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 278534'),
(2032, 0, 0, 404998, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 404998'),
(2033, 0, 0, 407714, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 407714'),
(2034, 0, 0, 16777216, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16777216'),
(2035, 0, 0, 16777248, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16777248'),
(2036, 0, 0, 16777250, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16777250'),
(2037, 0, 0, 16777264, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16777264'),
(2038, 0, 0, 16777312, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16777312'),
(2039, 0, 0, 16777376, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16777376'),
(2040, 0, 0, 16779424, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16779424'),
(2041, 0, 0, 16779428, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16779428'),
(2042, 0, 0, 16779488, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16779488'),
(2043, 0, 0, 16781344, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16781344'),
(2044, 0, 0, 16781984, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16781984'),
(2045, 0, 0, 16783392, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16783392'),
(2046, 0, 0, 16788644, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16788644'),
(2047, 0, 0, 16791714, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16791714'),
(2048, 0, 0, 16794664, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16794664'),
(2049, 0, 0, 16794668, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16794668'),
(2050, 0, 0, 16794676, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16794676'),
(2051, 0, 0, 16827436, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16827436'),
(2052, 0, 0, 16932526, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 16932526'),
(2053, 0, 0, 17039394, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17039394'),
(2054, 0, 0, 17039520, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17039520'),
(2055, 0, 0, 17041570, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17041570'),
(2056, 0, 0, 17045536, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17045536'),
(2057, 0, 0, 17171490, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17171490'),
(2058, 0, 0, 17171494, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17171494'),
(2059, 0, 0, 17204258, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17204258'),
(2060, 0, 0, 17825824, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17825824'),
(2061, 0, 0, 17825826, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17825826'),
(2062, 0, 0, 17826336, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 17826336'),
(2063, 0, 0, 25198706, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 25198706'),
(2064, 0, 0, 25574434, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 25574434'),
(2065, 0, 0, 26216098, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 26216098'),
(2066, 0, 0, 67272418, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 67272418'),
(2067, 0, 0, 75497986, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 75497986'),
(2068, 0, 0, 75502082, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 75502082'),
(2069, 0, 0, 75765794, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 75765794'),
(2070, 0, 0, 84032160, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 84032160'),
(2071, 0, 0, 84180644, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 84180644');

DELETE FROM `creature_immunities` WHERE `ID` IN (2072,2073,2074,2075,2076,2077,2078,2079,2080,2081,2082,2083,2084,2085,2086,2087,2088,2089,2090,2091,2092,2093,2094,2095,2096,2097,2098,2099,2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2112,2113,2114,2115,2116,2117,2118,2119,2120,2121);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2072, 0, 0, 84180654, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 84180654'),
(2073, 0, 0, 92569262, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 92569262'),
(2074, 0, 0, 93617828, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 93617828'),
(2075, 0, 0, 134217728, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134217728'),
(2076, 0, 0, 134219776, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134219776'),
(2077, 0, 0, 134221834, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134221834'),
(2078, 0, 0, 134368350, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134368350'),
(2079, 0, 0, 134487696, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134487696'),
(2080, 0, 0, 134487698, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134487698'),
(2081, 0, 0, 134610954, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 134610954'),
(2082, 0, 0, 142884558, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 142884558'),
(2083, 0, 0, 151259878, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 151259878'),
(2084, 0, 0, 151262366, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 151262366'),
(2085, 0, 0, 151262398, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 151262398'),
(2086, 0, 0, 151273214, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 151273214'),
(2087, 0, 0, 151314166, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 151314166'),
(2088, 0, 0, 151401654, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 151401654'),
(2089, 0, 0, 152469182, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 152469182'),
(2090, 0, 0, 159516926, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 159516926'),
(2091, 0, 0, 160853686, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 160853686'),
(2092, 0, 0, 160857782, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 160857782'),
(2093, 0, 0, 160857790, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 160857790'),
(2094, 0, 0, 160857854, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 160857854'),
(2095, 0, 0, 161361662, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 161361662'),
(2096, 0, 0, 201719818, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 201719818'),
(2097, 0, 0, 226915902, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 226915902'),
(2098, 0, 0, 227962558, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 227962558'),
(2099, 0, 0, 688815860, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 688815860'),
(2100, 0, 0, 1002405630, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1002405630'),
(2101, 0, 0, 1073741824, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073741824'),
(2102, 0, 0, 1073741826, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073741826'),
(2103, 0, 0, 1073741892, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073741892'),
(2104, 0, 0, 1073758240, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073758240'),
(2105, 0, 0, 1073873920, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073873920'),
(2106, 0, 0, 1073877158, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073877158'),
(2107, 0, 0, 1073886882, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1073886882'),
(2108, 0, 0, 1074009602, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1074009602'),
(2109, 0, 0, 1074167486, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1074167486'),
(2110, 0, 0, 1075202048, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1075202048'),
(2111, 0, 0, 1082677838, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1082677838'),
(2112, 0, 0, 1082686030, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1082686030'),
(2113, 0, 0, 1082686046, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1082686046'),
(2114, 0, 0, 1090534560, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090534560'),
(2115, 0, 0, 1090679030, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090679030'),
(2116, 0, 0, 1090681014, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090681014'),
(2117, 0, 0, 1090681270, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090681270'),
(2118, 0, 0, 1090936558, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090936558'),
(2119, 0, 0, 1090936574, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090936574'),
(2120, 0, 0, 1090940076, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090940076'),
(2121, 0, 0, 1090940670, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090940670');

DELETE FROM `creature_immunities` WHERE `ID` IN (2122,2123,2124,2125,2126,2127,2128,2129,2130,2131,2132,2133,2134,2135,2136,2137,2138,2139,2140,2141,2142,2143,2144,2145,2146,2147,2148,2149,2150,2151,2152,2153,2154,2155,2156,2157,2158,2159,2160,2161,2162,2163,2164,2165,2166,2167,2168,2169,2170,2171);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2122, 0, 0, 1090944742, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090944742'),
(2123, 0, 0, 1090944766, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1090944766'),
(2124, 0, 0, 1099040290, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1099040290'),
(2125, 0, 0, 1099043874, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1099043874'),
(2126, 0, 0, 1099060258, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1099060258'),
(2127, 0, 0, 1100219550, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100219550'),
(2128, 0, 0, 1100248830, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100248830'),
(2129, 0, 0, 1100350654, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100350654'),
(2130, 0, 0, 1100359230, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100359230'),
(2131, 0, 0, 1100366910, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100366910'),
(2132, 0, 0, 1100375718, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100375718'),
(2133, 0, 0, 1100379710, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100379710'),
(2134, 0, 0, 1100379774, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100379774'),
(2135, 0, 0, 1100904190, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100904190'),
(2136, 0, 0, 1100906238, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1100906238'),
(2137, 0, 0, 1102477054, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1102477054'),
(2138, 0, 0, 1102872318, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1102872318'),
(2139, 0, 0, 1141118466, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1141118466'),
(2140, 0, 0, 1158053548, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1158053548'),
(2141, 0, 0, 1158053550, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1158053550'),
(2142, 0, 0, 1158053630, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1158053630'),
(2143, 0, 0, 1167484670, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1167484670'),
(2144, 0, 0, 1167488694, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1167488694'),
(2145, 0, 0, 1207983274, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1207983274'),
(2146, 0, 0, 1208099366, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1208099366'),
(2147, 0, 0, 1208110334, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1208110334'),
(2148, 0, 0, 1208117942, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1208117942'),
(2149, 0, 0, 1208118454, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1208118454'),
(2150, 0, 0, 1208123134, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1208123134'),
(2151, 0, 0, 1208245410, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1208245410'),
(2152, 0, 0, 1209171606, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1209171606'),
(2153, 0, 0, 1217817766, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1217817766'),
(2154, 0, 0, 1224758964, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224758964'),
(2155, 0, 0, 1224758966, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224758966'),
(2156, 0, 0, 1224764576, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224764576'),
(2157, 0, 0, 1224891646, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224891646'),
(2158, 0, 0, 1224892158, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224892158'),
(2159, 0, 0, 1224899750, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224899750'),
(2160, 0, 0, 1224899830, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1224899830'),
(2161, 0, 0, 1225030910, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225030910'),
(2162, 0, 0, 1225031358, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225031358'),
(2163, 0, 0, 1225064188, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225064188'),
(2164, 0, 0, 1225162494, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225162494'),
(2165, 0, 0, 1225293566, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225293566'),
(2166, 0, 0, 1225424638, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225424638'),
(2167, 0, 0, 1225588478, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225588478'),
(2168, 0, 0, 1225686782, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1225686782'),
(2169, 0, 0, 1226206902, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1226206902'),
(2170, 0, 0, 1226209946, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1226209946'),
(2171, 0, 0, 1226209974, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1226209974');

DELETE FROM `creature_immunities` WHERE `ID` IN (2172,2173,2174,2175,2176,2177,2178,2179,2180,2181,2182,2183,2184,2185,2186,2187,2188,2189,2190,2191,2192,2193,2194,2195,2196,2197,2198,2199,2200,2201,2202,2203,2204,2205,2206,2207,2208,2209,2210,2211,2212,2213,2214,2215,2216,2217,2218,2219,2220,2221);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2172, 0, 0, 1226210998, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1226210998'),
(2173, 0, 0, 1226211006, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1226211006'),
(2174, 0, 0, 1226211070, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1226211070'),
(2175, 0, 0, 1230420214, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1230420214'),
(2176, 0, 0, 1233288886, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1233288886'),
(2177, 0, 0, 1233419518, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1233419518'),
(2178, 0, 0, 1233551102, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1233551102'),
(2179, 0, 0, 1233944318, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1233944318'),
(2180, 0, 0, 1234075390, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234075390'),
(2181, 0, 0, 1234568766, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234568766'),
(2182, 0, 0, 1234583806, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234583806'),
(2183, 0, 0, 1234595510, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234595510'),
(2184, 0, 0, 1234595518, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234595518'),
(2185, 0, 0, 1234595582, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234595582'),
(2186, 0, 0, 1234597430, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234597430'),
(2187, 0, 0, 1234599094, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599094'),
(2188, 0, 0, 1234599158, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599158'),
(2189, 0, 0, 1234599606, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599606'),
(2190, 0, 0, 1234599610, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599610'),
(2191, 0, 0, 1234599614, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599614'),
(2192, 0, 0, 1234599654, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599654'),
(2193, 0, 0, 1234599670, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599670'),
(2194, 0, 0, 1234599678, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234599678'),
(2195, 0, 0, 1234632374, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234632374'),
(2196, 0, 0, 1234992894, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1234992894'),
(2197, 0, 0, 1235119870, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1235119870'),
(2198, 0, 0, 1235123964, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1235123964'),
(2199, 0, 0, 1235123966, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1235123966'),
(2200, 0, 0, 1237221118, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1237221118'),
(2201, 0, 0, 1275494326, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1275494326'),
(2202, 0, 0, 1291996862, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1291996862'),
(2203, 0, 0, 1292000954, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292000954'),
(2204, 0, 0, 1292000958, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292000958'),
(2205, 0, 0, 1292009150, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292009150'),
(2206, 0, 0, 1292033724, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292033724'),
(2207, 0, 0, 1292033726, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292033726'),
(2208, 0, 0, 1292270270, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292270270'),
(2209, 0, 0, 1292271166, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292271166'),
(2210, 0, 0, 1292271294, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292271294'),
(2211, 0, 0, 1292271358, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1292271358'),
(2212, 0, 0, 1293188798, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293188798'),
(2213, 0, 0, 1293311670, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293311670'),
(2214, 0, 0, 1293315754, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293315754'),
(2215, 0, 0, 1293315774, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293315774'),
(2216, 0, 0, 1293317684, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293317684'),
(2217, 0, 0, 1293318838, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293318838'),
(2218, 0, 0, 1293319862, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293319862'),
(2219, 0, 0, 1293319870, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293319870'),
(2220, 0, 0, 1293319926, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293319926'),
(2221, 0, 0, 1293876926, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1293876926');

DELETE FROM `creature_immunities` WHERE `ID` IN (2222,2223,2224,2225,2226,2227,2228,2229,2230,2231,2232,2233,2234,2235,2236,2237,2238,2239,2240,2241,2242,2243,2244,2245,2246,2247,2248,2249,2250,2251,2252,2253,2254,2255,2256,2257,2258,2259,2260,2261,2262,2263,2264,2265,2266,2267,2268,2269,2270,2271);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2222, 0, 0, 1300692542, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1300692542'),
(2223, 0, 0, 1300692670, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1300692670'),
(2224, 0, 0, 1301053166, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301053166'),
(2225, 0, 0, 1301184254, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301184254'),
(2226, 0, 0, 1301446398, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301446398'),
(2227, 0, 0, 1301677626, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301677626'),
(2228, 0, 0, 1301677630, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301677630'),
(2229, 0, 0, 1301702270, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301702270'),
(2230, 0, 0, 1301703934, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301703934'),
(2231, 0, 0, 1301704382, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301704382'),
(2232, 0, 0, 1301704446, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301704446'),
(2233, 0, 0, 1301706494, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301706494'),
(2234, 0, 0, 1301707958, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301707958'),
(2235, 0, 0, 1301708022, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708022'),
(2236, 0, 0, 1301708462, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708462'),
(2237, 0, 0, 1301708470, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708470'),
(2238, 0, 0, 1301708478, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708478'),
(2239, 0, 0, 1301708526, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708526'),
(2240, 0, 0, 1301708534, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708534'),
(2241, 0, 0, 1301708538, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708538'),
(2242, 0, 0, 1301708540, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708540'),
(2243, 0, 0, 1301708542, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301708542'),
(2244, 0, 0, 1301741246, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301741246'),
(2245, 0, 0, 1301741310, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1301741310'),
(2246, 0, 0, 1302232766, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1302232766'),
(2247, 0, 0, 1302232830, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1302232830'),
(2248, 0, 0, 1303871230, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1303871230'),
(2249, 0, 0, 1304395518, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1304395518'),
(2250, 0, 0, 1304428286, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1304428286'),
(2251, 0, 0, 1305378558, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1305378558'),
(2252, 0, 0, 1335787254, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1335787254'),
(2253, 0, 0, 1539276542, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1539276542'),
(2254, 0, 0, 1770663678, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1770663678'),
(2255, 0, 0, 1770946302, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1770946302'),
(2256, 0, 0, 1804534846, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 1804534846'),
(2257, 0, 0, 2013265920, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2013265920'),
(2258, 0, 0, 2013528064, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2013528064'),
(2259, 0, 0, 2013528100, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2013528100'),
(2260, 0, 0, 2013660192, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2013660192'),
(2261, 0, 0, 2022966272, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2022966272'),
(2262, 0, 0, 2030453792, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2030453792'),
(2263, 0, 0, 2031386302, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031386302'),
(2264, 0, 0, 2031502368, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031502368'),
(2265, 0, 0, 2031502372, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031502372'),
(2266, 0, 0, 2031512736, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031512736'),
(2267, 0, 0, 2031516704, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031516704'),
(2268, 0, 0, 2031516708, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031516708'),
(2269, 0, 0, 2031516836, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031516836'),
(2270, 0, 0, 2031517372, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2031517372'),
(2271, 0, 0, 2038842400, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2038842400');

DELETE FROM `creature_immunities` WHERE `ID` IN (2272,2273,2274,2275,2276,2277,2278,2279,2280,2281,2282,2283,2284,2285,2286,2287,2288,2289,2290,2291,2292,2293,2294,2295,2296,2297,2298,2299,2300,2301,2302,2303,2304,2305,2306,2307,2308,2309,2310,2311,2312,2313,2314,2315,2316,2317,2318,2319,2320,2321);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2272, 0, 0, 2038842402, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2038842402'),
(2273, 0, 0, 2039890978, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039890978'),
(2274, 0, 0, 2039890982, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039890982'),
(2275, 0, 0, 2039901750, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039901750'),
(2276, 0, 0, 2039905318, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039905318'),
(2277, 0, 0, 2039905444, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039905444'),
(2278, 0, 0, 2039905446, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039905446'),
(2279, 0, 0, 2039905454, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039905454'),
(2280, 0, 0, 2039905956, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039905956'),
(2281, 0, 0, 2039905974, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039905974'),
(2282, 0, 0, 2039906038, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039906038'),
(2283, 0, 0, 2039906046, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2039906046'),
(2284, 0, 0, 2041872062, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2041872062'),
(2285, 0, 0, 2042588340, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2042588340'),
(2286, 0, 0, 2042588342, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2042588342'),
(2287, 0, 0, 2042592436, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2042592436'),
(2288, 0, 0, 2042592438, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2042592438'),
(2289, 0, 0, 2044099622, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2044099622'),
(2290, 0, 0, 2076147382, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2076147382'),
(2291, 0, 0, 2107014838, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2107014838'),
(2292, 0, 0, 2143256254, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2143256254'),
(2293, 0, 0, 2143289022, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2143289022'),
(2294, 0, 0, 2147483646, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 2147483646'),
(2295, 0, 0, 3116367612, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 3116367612'),
(2296, 0, 0, 3386277110, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 3386277110'),
(2297, 0, 0, 4294934270, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4294934270'),
(2298, 0, 0, 4294967038, '', '', 0, 0, 'SchoolMask 0, MechanicsMask 4294967038'),
(2299, 1, 0, 16777248, '', '', 0, 0, 'SchoolMask 1, MechanicsMask 16777248'),
(2300, 1, 0, 1301708478, '', '', 0, 0, 'SchoolMask 1, MechanicsMask 1301708478'),
(2301, 4, 0, 0, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 0'),
(2302, 4, 0, 32, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 32'),
(2303, 4, 0, 17416, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 17416'),
(2304, 4, 0, 17420, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 17420'),
(2305, 4, 0, 17432, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 17432'),
(2306, 4, 0, 16784544, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 16784544'),
(2307, 4, 0, 1226210998, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1226210998'),
(2308, 4, 0, 1226211006, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1226211006'),
(2309, 4, 0, 1234599606, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1234599606'),
(2310, 4, 0, 1292000954, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1292000954'),
(2311, 4, 0, 1292271294, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1292271294'),
(2312, 4, 0, 1293188798, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1293188798'),
(2313, 4, 0, 1301704446, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1301704446'),
(2314, 4, 0, 1301708478, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1301708478'),
(2315, 4, 0, 1301708542, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 1301708542'),
(2316, 4, 0, 2039905974, '', '', 0, 0, 'SchoolMask 4, MechanicsMask 2039905974'),
(2317, 8, 0, 0, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 0'),
(2318, 8, 0, 16, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 16'),
(2319, 8, 0, 1090674362, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1090674362'),
(2320, 8, 0, 1217817766, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1217817766'),
(2321, 8, 0, 1234599606, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1234599606');

DELETE FROM `creature_immunities` WHERE `ID` IN (2322,2323,2324,2325,2326,2327,2328,2329,2330,2331,2332,2333,2334,2335,2336,2337,2338,2339,2340,2341,2342,2343,2344,2345,2346,2347,2348,2349,2350,2351,2352,2353,2354,2355);
INSERT INTO `creature_immunities` (`ID`, `SchoolMask`, `DispelTypeMask`, `MechanicsMask`, `Effects`, `Auras`, `ImmuneAoE`, `ImmuneChain`, `Comment`) VALUES
(2322, 8, 0, 1291998778, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1291998778'),
(2323, 8, 0, 1292000954, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1292000954'),
(2324, 8, 0, 1292000958, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1292000958'),
(2325, 8, 0, 1292271358, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1292271358'),
(2326, 8, 0, 1293188798, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1293188798'),
(2327, 8, 0, 1293319870, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1293319870'),
(2328, 8, 0, 1300397758, '', '', 0, 0, 'SchoolMask 8, MechanicsMask 1300397758'),
(2329, 16, 0, 0, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 0'),
(2330, 16, 0, 16, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 16'),
(2331, 16, 0, 20516, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 20516'),
(2332, 16, 0, 16777248, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 16777248'),
(2333, 16, 0, 1090674362, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1090674362'),
(2334, 16, 0, 1217817766, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1217817766'),
(2335, 16, 0, 1226210998, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1226210998'),
(2336, 16, 0, 1234599606, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1234599606'),
(2337, 16, 0, 1292000954, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1292000954'),
(2338, 16, 0, 1293188798, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1293188798'),
(2339, 16, 0, 1301708538, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1301708538'),
(2340, 16, 0, 1301708542, '', '', 0, 0, 'SchoolMask 16, MechanicsMask 1301708542'),
(2341, 32, 0, 0, '', '', 0, 0, 'SchoolMask 32, MechanicsMask 0'),
(2342, 64, 0, 0, '', '', 0, 0, 'SchoolMask 64, MechanicsMask 0'),
(2343, 64, 0, 32, '', '', 0, 0, 'SchoolMask 64, MechanicsMask 32'),
(2344, 64, 0, 6688, '', '', 0, 0, 'SchoolMask 64, MechanicsMask 6688'),
(2345, 64, 0, 10368, '', '', 0, 0, 'SchoolMask 64, MechanicsMask 10368'),
(2346, 64, 0, 1234599094, '', '', 0, 0, 'SchoolMask 64, MechanicsMask 1234599094'),
(2347, 64, 0, 1235123966, '', '', 0, 0, 'SchoolMask 64, MechanicsMask 1235123966'),
(2348, 96, 0, 0, '', '', 0, 0, 'SchoolMask 96, MechanicsMask 0'),
(2349, 116, 0, 0, '', '', 0, 0, 'SchoolMask 116, MechanicsMask 0'),
(2350, 124, 0, 17171490, '', '', 0, 0, 'SchoolMask 124, MechanicsMask 17171490'),
(2351, 124, 0, 1234599614, '', '', 0, 0, 'SchoolMask 124, MechanicsMask 1234599614'),
(2352, 126, 0, 0, '', '', 0, 0, 'SchoolMask 126, MechanicsMask 0'),
(2353, 126, 0, 1292271286, '', '', 0, 0, 'SchoolMask 126, MechanicsMask 1292271286'),
(2354, 127, 0, 16777248, '', '', 0, 0, 'SchoolMask 127, MechanicsMask 16777248'),
(2355, 127, 0, 1301741246, '', '', 0, 0, 'SchoolMask 127, MechanicsMask 1301741246');

-- Update creature_template.CreatureImmunitiesId
UPDATE `creature_template` SET `CreatureImmunitiesId`=1537 WHERE `entry` IN (17543,18404);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1664 WHERE `entry` IN (4468);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1794 WHERE `entry` IN (3253,36551,37564);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1964 WHERE `entry` IN (20047);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1971 WHERE `entry` IN (20038,25367,25368,25371,25507);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1972 WHERE `entry` IN (352,523,752,931,1387,1571,1572,1573,2299,2409,2432,2835,2851,2858,2859,2861,2941,2995,3305,3310,3615,3725,3728,4312,4314,4317,4321,6026,6726,7823,7824,8018,8020,8609,8610,10378,11139,11830,11899,11900,11901,12596,12616,12617,12740,13177,15178,16218,16461,16593,16699,16704,17083,17229,17398,17420,17429,17461,17491,17622,17695,18048,18049,18050,18052,18053,18054,18057,18058,18603,18609,18610,18612,18615,18619,18631,18632,18635,18636,18830,19885,19887,19889,19903,20033,20034,20255,20256,20257,20258,20259,20260,20261,20578,20579,20580,20581,20582,20586,20587,20590,20594,20621,20624,20626,20639,20640,20641,20642,20644,20645,20661,20693,20695,20699,20701,20923,21230,21522,21524,21527,21528,21532,21545,21548,21563,21564,21565,21570,21571,21573,21575,21576,21585,21587,21613,21857,21865,21873,22876,23168,24994,25509,25591,25593,25595,25599,25851,26799,26800,26801,26802,26803,26805,27947,27949,29503,29626,30460,30478,30485,30495,30496,30497,30498,30508,30509,32922,32923,32924,32925,33235,33236,33259,33287,33355,33527,33579,33620,33622,33624,33626,33627,33629,33662,33669,33672,33696,33701,33737,33741,33754,33755,33757,33758,33774,33775,33816,33818,33819);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1972 WHERE `entry` IN (33820,33822,33823,33824,33827,33828,33829,33830,33831,33832,33956,33957,34054,34113,34144,34145,34198,34199,34236,34237,34255,34256,34257,34441,34442,34443,34444,34445,34447,34448,34449,34450,34451,34453,34454,34455,34456,34458,34459,34460,34461,34463,34465,34466,34467,34468,34469,34470,34471,34472,34473,34474,34475,35465,35610,35662,35663,35664,35665,35666,35667,35668,35669,35670,35671,35672,35673,35674,35675,35676,35680,35681,35682,35683,35684,35685,35686,35687,35688,35689,35690,35691,35692,35693,35694,35695,35696,35697,35699,35700,35701,35702,35703,35704,35705,35706,35707,35708,35709,35710,35711,35712,35713,35714,35715,35716,35718,35719,35720,35721,35722,35723,35724,35725,35726,35728,35729,35730,35731,35732,35733,35734,35735,35736,35737,35738,35739,35740,35741,35742,35743,35744,35745,35746,35747,35748,35749,35774,35775,35776,36070,36301,36302,36303,36473,36474,36475);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1973 WHERE `entry` IN (12737);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1974 WHERE `entry` IN (13996,14462,25752,25753,25758,25792);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1975 WHERE `entry` IN (24553,24554,24555,24556,24557,24558,24559,24561,24656,25541,25549,25550,25553,25555,25556,25574,25578,25579);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1976 WHERE `entry` IN (8717,21549);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1977 WHERE `entry` IN (30839);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1978 WHERE `entry` IN (20869,21586);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1979 WHERE `entry` IN (2673,2674,4952,12426,16844,16968,17578,18215,19139,21157,21849,22038,22466,22482,24792,30527,31143,31144,31146,32541,32542,32543,32545,32546,32547,32666,32667,33229,33243,33272,37127,38126);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1980 WHERE `entry` IN (20897,23398);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1981 WHERE `entry` IN (21597,22879,22882,22945,23018,23049,23147,23172,23223,23235,23236,23237,24815,25566);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1982 WHERE `entry` IN (5277,5280,5283,8319,16098,17669,20574);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1983 WHERE `entry` IN (22299,22300);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1984 WHERE `entry` IN (3678);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1985 WHERE `entry` IN (23584);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1986 WHERE `entry` IN (19005,22874,22885);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1987 WHERE `entry` IN (18707);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1988 WHERE `entry` IN (18533,20772);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1989 WHERE `entry` IN (21166);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1990 WHERE `entry` IN (18044,22939);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1991 WHERE `entry` IN (8908);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1992 WHERE `entry` IN (18258);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1993 WHERE `entry` IN (18046);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1994 WHERE `entry` IN (22957,22962);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1995 WHERE `entry` IN (18420,21574);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1996 WHERE `entry` IN (20052);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1997 WHERE `entry` IN (21225);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1998 WHERE `entry` IN (24549);
UPDATE `creature_template` SET `CreatureImmunitiesId`=1999 WHERE `entry` IN (34702,34703,35569,35570,35571,35572,35617,36082,36083,36084,36085,36086,36087,36088,36089,36090,36091);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2000 WHERE `entry` IN (20048);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2001 WHERE `entry` IN (20883,21615);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2002 WHERE `entry` IN (28163,28168);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2003 WHERE `entry` IN (12800,12801,12802);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2004 WHERE `entry` IN (24047);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2005 WHERE `entry` IN (18423);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2006 WHERE `entry` IN (12458);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2007 WHERE `entry` IN (22875);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2008 WHERE `entry` IN (7397);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2009 WHERE `entry` IN (13601);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2010 WHERE `entry` IN (30829,30830,30831);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2011 WHERE `entry` IN (2667,2671,7076,7077,7309,8376,8816,9657,15104,15108,15429,15631,15698,15706,15904,15910,15964,15973,16511);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2012 WHERE `entry` IN (26688);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2013 WHERE `entry` IN (16700,17732,19632,20174,24179,29273);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2014 WHERE `entry` IN (14261,14262,14263,14264,14265,20588,20589);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2015 WHERE `entry` IN (17816,17817,19884,19892);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2016 WHERE `entry` IN (19513,19598,19865,21560,21561,21562);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2017 WHERE `entry` IN (17465,20583,22955);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2018 WHERE `entry` IN (32361,32377,32409,32417,32422,32429,32447,32475,32481,32485);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2019 WHERE `entry` IN (22965);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2020 WHERE `entry` IN (24180);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2021 WHERE `entry` IN (24065);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2022 WHERE `entry` IN (21515);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2023 WHERE `entry` IN (24530);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2024 WHERE `entry` IN (18322,20696);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2025 WHERE `entry` IN (15146,25363);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2026 WHERE `entry` IN (17818,17864,18848,20656,20881,20900,21619,21621,25592,25948);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2027 WHERE `entry` IN (7728);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2028 WHERE `entry` IN (25798,25799);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2029 WHERE `entry` IN (26928,26929,26930,30511,30512,30513);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2030 WHERE `entry` IN (18182);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2031 WHERE `entry` IN (32500);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2032 WHERE `entry` IN (17731,20173);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2033 WHERE `entry` IN (19191);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2034 WHERE `entry` IN (19261);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (3,36,114,115,200,201,204,210,302,314,315,392,412,480,503,511,522,570,572,573,604,624,625,626,725,846,882,948,1159,1270,1488,1489,1491,1501,1502,1525,1526,1527,1528,1529,1530,1532,1533,1654,1656,1663,1666,1674,1675,1696,1716,1717,1720,1753,1772,1773,1790,1791,1792,1793,1794,1795,1796,1798,1805,1847,1849,1850,1852,1866,1868,1917,1918,1919,1921,1939,1940,1941,1942,1943,1944,1948,1971,1974,2045,2056,2217,2218,2219,2220,2221,2222,2227,2278,2288,2325,2433,2475,2479,2520,2531,2535,2536,2537,2623,2676,2678,2748,2763,2922,3094,3301,3538,3558,3565,3617,3654,3669,3670,3671,3673,3674,3799,3802,3803,3869,3870,3876,3914,3940,3941,3942,3983,4073,4074,4251,4252,4260,4308,4473,4474,4475,4476,4550,4566,4606,4610,4612,4854,4872,4945,4946,4958,5097,5202,5263,5267,5270,5271,5400,5621,5624,5626,5627,5674,5685,5686,5687,5712,5713,5714,5715,5716,5717,5723,5775,5854,5912,5954,6036,6092,6106,6107,6108,6225,6226,6227,6230,6231,6232,6233,6234,6346,6386,6426,6427,6486,6493,6669,6906);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (6907,6908,6910,7023,7039,7050,7067,7068,7069,7070,7071,7072,7075,7166,7206,7209,7270,7273,7274,7276,7286,7291,7310,7327,7328,7329,7332,7333,7334,7340,7347,7348,7349,7351,7352,7353,7354,7355,7356,7357,7358,7374,7375,7503,7504,7527,7624,7784,7791,7806,7807,7849,7895,7897,8035,8447,8500,8501,8530,8531,8532,8534,8535,8536,8537,8543,8544,8545,8552,8555,8556,8557,8558,8559,8567,8580,8585,8615,8663,8856,9437,9438,9439,9441,9442,9443,9476,9623,10080,10081,10082,10117,10381,10382,10383,10395,10397,10402,10403,10405,10406,10407,10408,10409,10411,10412,10413,10414,10416,10417,10463,10464,10479,10480,10481,10483,10484,10492,10493,10494,10495,10497,10498,10499,10500,10580,10666,10684,10698,10699,10778,10801,10810,10818,10819,10820,10821,10825,10836,10926,10927,10936,10937,10939,10943,10944,10945,10946,10949,10950,10951,10953,10954,11027,11030,11075,11082,11151,11153,11154,11155,11179,11195,11199,11216,11217,11263,11277,11278,11279,11280,11281,11282,11283,11286,11287,11290,11291,11292,11316,11412,11414,11415,11446,11468,11469,11470,11471,11472,11473,11474,11475,11477,11517,11518,11519,11520,11551,11580,11598);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (11628,11684,11875,11936,12238,12239,12240,12241,12242,12243,12248,12250,12261,12262,12263,12363,12364,12365,12367,12368,12379,12380,12385,12473,12865,13146,13378,13416,13619,13738,13739,13740,13741,13742,14224,14308,14337,14358,14364,14484,14485,14494,14511,14512,14513,14514,14518,14519,14520,14521,14551,14552,14553,14554,14562,14563,14605,14683,14685,14686,14687,14688,14691,14692,14694,14695,14696,14697,14698,14699,14700,14701,14702,14703,14704,14705,14706,14707,14708,14709,14710,14711,14712,14713,14714,14825,14826,14986,15079,15081,15117,15121,15163,15195,15349,15364,15368,15374,15376,15377,15547,15548,15551,15654,15655,15656,15657,15658,15665,15720,15958,16025,16026,16039,16040,16059,16066,16067,16093,16099,16103,16104,16119,16120,16125,16138,16141,16145,16146,16148,16153,16154,16159,16163,16169,16184,16211,16245,16246,16247,16248,16249,16250,16298,16300,16301,16302,16303,16305,16306,16307,16308,16309,16311,16312,16313,16314,16316,16319,16320,16321,16322,16323,16324,16325,16326,16327,16328,16329,16342,16357,16382,16383,16388,16389,16390,16393,16394,16402,16403,16406,16407,16408,16409,16410,16411,16412,16415,16424,16425,16426,16432,16437,16439,16451,16459,16460,16468,16470,16471);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (16481,16482,16525,16526,16805,16806,16811,16812,16813,16814,16815,16861,16904,16905,16906,16976,16977,16978,17007,17063,17064,17067,17086,17261,17415,17466,17503,17588,17589,17592,17612,17660,17672,17674,17714,17878,17895,17897,17898,17902,17903,17905,17906,18043,18287,18319,18320,18327,18355,18367,18441,18460,18478,18498,18499,18500,18501,18506,18521,18524,18556,18557,18558,18559,18588,18643,18689,18700,18797,18872,18873,19416,19417,19460,19463,19464,19488,19489,19543,19544,19545,19546,19579,19580,19682,19698,19719,19736,19749,19751,19825,19826,19827,19846,19863,19864,19872,19873,19874,19875,19876,19878,19879,19881,19937,20117,20137,20298,20303,20305,20310,20311,20312,20313,20315,20316,20317,20319,20320,20321,20322,20323,20409,20410,20480,20483,20495,20496,20512,20662,20691,20697,20698,20934,21049,21058,21065,21093,21163,21184,21198,21199,21200,21201,21202,21324,21354,21384,21385,21386,21430,21446,21449,21450,21452,21628,21636,21638,21651,21763,21778,21779,21784,21787,21788,21795,21797,21801,21815,21866,21867,21869,21870,21941,22025,22041,22045,22062,22138,22226,22235,22369,22441,22452,22454,22701,22706,23066,23067,23068,23103,23109,23111,23126,23161,23193,23204,23370,23371,23389);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (23408,23503,23509,23545,23554,23555,23561,23562,23563,23575,23643,23644,23645,23786,23861,23898,23904,23935,23970,23992,23993,24013,24019,24027,24029,24041,24073,24074,24084,24118,24153,24168,24177,24207,24246,24247,24248,24258,24262,24266,24267,24272,24327,24344,24440,24446,24447,24485,24546,24562,24563,24564,24566,24621,24622,24623,24624,24625,24626,24627,24693,24695,24712,24789,24790,24796,24808,24814,24871,24872,24874,24875,24876,24877,24880,25027,25028,25041,25224,25227,25228,25268,25294,25296,25330,25331,25332,25333,25350,25351,25352,25359,25365,25366,25375,25377,25382,25383,25386,25387,25393,25396,25445,25451,25452,25453,25462,25463,25465,25469,25542,25546,25559,25582,25600,25611,25619,25622,25625,25629,25650,25652,25655,25660,25668,25678,25682,25684,25981,26073,26076,26103,26115,26125,26126,26165,26195,26202,26203,26224,26225,26250,26252,26286,26287,26292,26294,26317,26318,26320,26336,26343,26344,26402,26404,26413,26455,26457,26458,26461,26475,26490,26491,26492,26501,26509,26515,26517,26518,26526,26536,26555,26570,26573,26605,26606,26607,26608,26621,26623,26624,26635,26636,26637,26638,26658,26669,26670,26676,26690,26691,26692,26694,26696,26702,26703,26769,26770,26771,26811);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (26812,26824,26830,26840,26841,26858,26871,26891,26946,26948,26966,26967,27018,27059,27105,27122,27152,27153,27165,27219,27220,27224,27225,27226,27229,27240,27241,27268,27270,27272,27282,27283,27284,27285,27286,27287,27288,27290,27335,27360,27362,27363,27370,27383,27400,27401,27410,27465,27505,27510,27513,27531,27533,27534,27551,27552,27556,27561,27604,27605,27611,27614,27616,27618,27620,27623,27624,27630,27631,27680,27683,27685,27686,27691,27693,27694,27696,27712,27729,27733,27734,27736,27737,27766,27767,27768,27769,27770,27771,27772,27773,27774,27775,27776,27777,27778,27779,27780,27781,27782,27797,27799,27800,27807,27808,27809,27821,27822,27823,27824,27825,27829,27835,27836,27848,27854,27871,27874,27941,27957,28005,28006,28007,28014,28018,28022,28023,28026,28101,28103,28104,28108,28144,28158,28159,28162,28170,28194,28199,28200,28201,28207,28208,28211,28212,28218,28220,28232,28242,28243,28246,28249,28255,28257,28258,28268,28270,28278,28349,28350,28356,28357,28364,28365,28369,28377,28383,28395,28405,28406,28412,28414,28419,28420,28421,28422,28423,28424,28425,28426,28427,28428,28429,28430,28431,28432,28433,28434,28435,28436,28437,28438,28444,28445,28446,28447,28448,28449,28450,28471);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (28472,28474,28475,28476,28487,28488,28498,28499,28500,28503,28506,28510,28512,28519,28528,28534,28564,28565,28570,28589,28590,28599,28603,28615,28628,28641,28642,28647,28651,28653,28654,28657,28658,28659,28666,28669,28670,28711,28732,28733,28734,28735,28736,28745,28747,28748,28749,28750,28752,28754,28756,28759,28760,28768,28769,28782,28788,28793,28802,28803,28805,28843,28864,28866,28867,28868,28869,28870,28871,28872,28875,28878,28879,28889,28890,28897,28901,28903,28905,28906,28907,28908,28909,28910,28911,28913,28914,28915,28919,28924,28925,28930,28931,28933,28934,28937,28943,28948,28998,29030,29031,29047,29051,29053,29062,29063,29064,29096,29097,29098,29101,29106,29107,29108,29109,29110,29111,29112,29113,29115,29117,29118,29119,29123,29128,29129,29133,29136,29153,29172,29173,29183,29185,29186,29187,29188,29189,29190,29191,29193,29194,29195,29196,29197,29198,29199,29200,29201,29202,29204,29205,29206,29207,29208,29209,29210,29212,29213,29214,29216,29217,29219,29221,29227,29230,29231,29232,29238,29239,29245,29246,29256,29263,29280,29286,29335,29340,29347,29349,29353,29354,29355,29356,29359,29362,29363,29371,29388,29394,29400,29414,29449,29450,29451,29453,29468,29480,29488,29501,29517);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (29519,29520,29522,29565,29566,29567,29570,29574,29576,29587,29609,29629,29632,29633,29634,29635,29646,29648,29654,29656,29697,29699,29704,29719,29720,29722,29738,29769,29770,29821,29823,29824,29825,29828,29831,29833,29835,29837,29840,29842,29851,29852,29856,29858,29859,29860,29863,29872,29882,29887,29890,29891,29892,29893,29894,29895,29897,29898,29899,29900,29901,29934,29935,29943,29974,29985,29986,29987,29988,29989,29990,30015,30016,30018,30027,30028,30029,30030,30031,30032,30033,30034,30047,30048,30049,30071,30074,30075,30083,30085,30087,30097,30135,30144,30150,30202,30203,30204,30205,30216,30230,30232,30235,30250,30264,30276,30277,30278,30283,30284,30285,30286,30287,30288,30303,30306,30307,30309,30310,30311,30333,30335,30338,30378,30389,30403,30404,30406,30409,30424,30432,30443,30471,30482,30486,30501,30523,30541,30542,30543,30544,30545,30546,30575,30593,30594,30597,30609,30629,30670,30687,30689,30696,30697,30698,30701,30728,30746,30778,30791,30806,30816,30817,30818,30819,30821,30822,30823,30836,30843,30851,30863,30864,30865,30894,30895,30920,30921,30922,30944,30945,30946,30947,30949,30951,30952,30953,30954,30955,30956,30957,30958,30960,30984,30985,30986,30987,30988,30989,30992);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (30993,31012,31014,31015,31029,31037,31039,31040,31042,31043,31048,31078,31082,31083,31084,31087,31088,31089,31090,31094,31095,31096,31097,31098,31099,31100,31104,31107,31110,31123,31135,31137,31139,31140,31141,31142,31147,31150,31152,31154,31155,31157,31159,31160,31161,31163,31178,31179,31183,31184,31187,31188,31191,31192,31193,31194,31195,31196,31198,31199,31200,31205,31207,31208,31220,31221,31222,31223,31224,31225,31226,31227,31231,31237,31251,31255,31263,31266,31268,31271,31274,31278,31283,31301,31318,31320,31321,31322,31323,31324,31325,31326,31327,31341,31342,31346,31347,31351,31352,31354,31355,31357,31361,31363,31396,31398,31411,31413,31438,31442,31443,31447,31449,31450,31451,31457,31460,31466,31468,31530,31531,31532,31554,31555,31556,31565,31583,31585,31586,31587,31588,31589,31590,31591,31593,31594,31595,31596,31597,31598,31599,31600,31601,31602,31603,31604,31605,31606,31607,31608,31609,31613,31614,31635,31647,31671,31681,31692,31702,31718,31721,31754,31775,31779,31780,31783,31787,31812,31813,31815,31843,31844,31847,31853,31900,32031,32037,32149,32160,32161,32163,32164,32175,32176,32178,32179,32181,32182,32183,32184,32188,32255,32257,32267,32272,32278,32280,32283,32284,32288);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (32292,32299,32300,32309,32323,32326,32350,32390,32391,32404,32408,32410,32423,32446,32467,32479,32480,32482,32483,32490,32492,32497,32499,32502,32503,32505,32507,32508,32511,32556,32593,32609,32767,32769,32770,32771,32772,32786,32787,33016,33017,33429,33438,33441,33499,33513,33519,33550,33663,33664,33667,33668,33687,33704,33798,34127,34154,34238,34801,35169,35255,35444,35461,35474,35493,35547,35557,35559,35560,35652,35653,35654,35763,36065,36066,36128,36173,36478,36503,36504,36522,36564,36595,36666,36677,36724,36725,36726,36792,36794,36796,36807,36824,36829,36830,36840,36841,36842,36844,36875,36877,36879,36880,36881,36886,36893,36896,36907,36916,36940,36941,37007,37011,37012,37022,37023,37038,37069,37120,37128,37228,37229,37232,37351,37357,37491,37493,37494,37495,37501,37502,37530,37532,37535,37538,37539,37541,37542,37544,37545,37546,37549,37550,37551,37563,37565,37569,37571,37586,37595,37612,37622,37635,37636,37637,37638,37639,37640,37642,37644,37655,37656,37657,37658,37662,37663,37664,37665,37666,37678,37711,37728,37729,37730,37731,37755,37845,37846,37857,37881,37893,37906,37945,37976,38004,38031,38057,38058,38059,38061,38062,38063,38073,38074,38077,38098,38099,38100,38101,38102);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2035 WHERE `entry` IN (38104,38105,38108,38134,38137,38151,38172,38173,38175,38176,38177,38184,38185,38186,38193,38197,38198,38216,38222,38248,38249,38260,38308,38309,38349,38350,38351,38352,38362,38367,38386,38388,38391,38392,38410,38419,38429,38430,38445,38446,38479,38480,38481,38487,38524,38525,38544,38545,38563,38564,38567,38568,38572,38610,38763,38857,38883,39048,39231,39232,39233,39234,39296,39639,40274);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2036 WHERE `entry` IN (25597,37695,39309,39310,39311);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2037 WHERE `entry` IN (8836);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2038 WHERE `entry` IN (7915,16111);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2039 WHERE `entry` IN (14682);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2040 WHERE `entry` IN (18259,18648);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2041 WHERE `entry` IN (20682);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2042 WHERE `entry` IN (20783,20784,20785,20786,20788,20789,20790);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2043 WHERE `entry` IN (14684,14690);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2044 WHERE `entry` IN (14693);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2045 WHERE `entry` IN (17725,17871,20188,20190);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2046 WHERE `entry` IN (22848);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2047 WHERE `entry` IN (11447,11497,11498);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2048 WHERE `entry` IN (1157,1158,1160,1534,1655,1800,1801,1802,1804,1946,1983,2044,2176,2177,2178,2638,3667,3801,4472,6116,6117,6133,7073,7074,7370,7523,7524,7864,8538,8539,8540,8541,8542,10387,10388,10389,10940,10947,10948,11064,11078,11141,11285,11288,11289,11296,11560,11620,11621,11686,11687,11873,12178,12179,12199,12377,12378,14564,16423);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2049 WHERE `entry` IN (1531,2184,3863,3872,3873,3875,3877,6118,10358,10384,10385,10938,10996,16143,16379);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2050 WHERE `entry` IN (18856);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2051 WHERE `entry` IN (6021,9299,10988);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2052 WHERE `entry` IN (15554);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2053 WHERE `entry` IN (22338);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2054 WHERE `entry` IN (23269);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2055 WHERE `entry` IN (19354);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2056 WHERE `entry` IN (17724,20185,20465,21943);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2057 WHERE `entry` IN (48,202,203,531,623,785,787,1110,1520,1522,1523,1657,1658,1783,1784,1785,1787,1788,1789,1865,1869,1870,1871,1890,1916,1973,2454,6388,6412,7343,7344,7346,7786,8477,8523,8524,8525,8526,8527,8528,8529,8884,10390,10391,10482,10816,10952,11076,11077,11156,11197,11200,11258,11476,11547,12208,12341,12342,12343,12344,14486,14489,14558,16299,16422,16438);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2058 WHERE `entry` IN (771,2283,2946,7341,7342,7345,10393,10394,10478,10486,10487,10488,10489,10491,10826,16380);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2059 WHERE `entry` IN (11561);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2060 WHERE `entry` IN (22953);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2061 WHERE `entry` IN (5711);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2062 WHERE `entry` IN (23401);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2063 WHERE `entry` IN (28443);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2064 WHERE `entry` IN (19307,20265);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2065 WHERE `entry` IN (17958);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2066 WHERE `entry` IN (12557);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2067 WHERE `entry` IN (22853);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2068 WHERE `entry` IN (22869,23339);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2069 WHERE `entry` IN (20875,21604);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2070 WHERE `entry` IN (21102);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2071 WHERE `entry` IN (21181,21251);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2072 WHERE `entry` IN (16504);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2073 WHERE `entry` IN (20866,20898,21598,21614,22954);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2074 WHERE `entry` IN (16414,16473);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2075 WHERE `entry` IN (35644,36558);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2076 WHERE `entry` IN (33060,33062,33067,33109,33167,34045);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2077 WHERE `entry` IN (19797);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2078 WHERE `entry` IN (17454);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2079 WHERE `entry` IN (17940,19891,21127);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2080 WHERE `entry` IN (21843);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2081 WHERE `entry` IN (21270,21274);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2082 WHERE `entry` IN (20873,21605);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2083 WHERE `entry` IN (20175);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2084 WHERE `entry` IN (17726,17735,20191,20193);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2085 WHERE `entry` IN (17727,20192);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2086 WHERE `entry` IN (20908,20909,21616,21617);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2087 WHERE `entry` IN (22849);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2088 WHERE `entry` IN (14349);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2089 WHERE `entry` IN (644);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2090 WHERE `entry` IN (15334,15725,15726,15728,15802);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2091 WHERE `entry` IN (18497,20299);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2092 WHERE `entry` IN (21694,21914,24068,25372,31655);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2093 WHERE `entry` IN (18796,20652);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2094 WHERE `entry` IN (17907);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2095 WHERE `entry` IN (20043,20044);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2096 WHERE `entry` IN (21268,21269,21271,21272,21273);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2097 WHERE `entry` IN (14987);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2098 WHERE `entry` IN (15630,15984);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2099 WHERE `entry` IN (25334,26523,27881,27894,28094,28312,28319,28366,28781,32627,32629,32795,32796,34775,34776,34777,34778,34793,34802,34922,34924,34929,34935,34944,35069,35273,35403,35405,35410,35413,35415,35417,35419,35421,35427,35429,35431,35433,35436,35819,36355,36356,36357,36358);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2100 WHERE `entry` IN (20992);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2101 WHERE `entry` IN (16507);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2102 WHERE `entry` IN (20593);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2103 WHERE `entry` IN (16857);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2104 WHERE `entry` IN (18554);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2105 WHERE `entry` IN (23586);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2106 WHERE `entry` IN (19886);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2107 WHERE `entry` IN (34657,34701,34705);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2108 WHERE `entry` IN (22845,23374);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2109 WHERE `entry` IN (12339);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2110 WHERE `entry` IN (10814);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2111 WHERE `entry` IN (23402);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2112 WHERE `entry` IN (23403);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2113 WHERE `entry` IN (23400);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2114 WHERE `entry` IN (6584);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2115 WHERE `entry` IN (17827,20165);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2116 WHERE `entry` IN (22930);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2117 WHERE `entry` IN (17671,20584,20993);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2118 WHERE `entry` IN (23196);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2119 WHERE `entry` IN (22880,22956,22964,23222,23239,23337,23399);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2120 WHERE `entry` IN (22199);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2121 WHERE `entry` IN (18680,22877,22884);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2122 WHERE `entry` IN (22960);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2123 WHERE `entry` IN (22844,22847,22873,22878,22963,23028,23030);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2124 WHERE `entry` IN (34605,34650,35658,35659);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2125 WHERE `entry` IN (36561,36571,40681,40682,40683,40684);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2126 WHERE `entry` IN (40417,40418,40419,40420,40421,40422,40423,40424);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2127 WHERE `entry` IN (37890,37949,38393,38394,38625,38626,38628,38629);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2128 WHERE `entry` IN (18692);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2129 WHERE `entry` IN (38009,38010,38135,38136,38395,38396,38397,38398,38630,38631,38632,38633,38634,38635,39000,39001);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2130 WHERE `entry` IN (38508,38596,38597,38598);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2131 WHERE `entry` IN (38472,38485);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2132 WHERE `entry` IN (34607,34648,35655,35656);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2133 WHERE `entry` IN (37863,38171,38727,38737);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2134 WHERE `entry` IN (36791,37868,37886,37934,38166,38167,38169,38170,38721,38722,38723,38724,38725,38733,38734,38735);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2135 WHERE `entry` IN (20032);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2136 WHERE `entry` IN (20040);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2137 WHERE `entry` IN (20035);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2138 WHERE `entry` IN (20050);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2139 WHERE `entry` IN (22846);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2140 WHERE `entry` IN (20216,20600,22910);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2141 WHERE `entry` IN (16545,22911);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2142 WHERE `entry` IN (23330);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2143 WHERE `entry` IN (36609,37799,39120,39121,39122,39284,39285,39286);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2144 WHERE `entry` IN (33346,33886);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2145 WHERE `entry` IN (22075);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2146 WHERE `entry` IN (20692);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2147 WHERE `entry` IN (18836);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2148 WHERE `entry` IN (11347);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2149 WHERE `entry` IN (11348);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2150 WHERE `entry` IN (17256);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2151 WHERE `entry` IN (22074);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2152 WHERE `entry` IN (14101);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2153 WHERE `entry` IN (639,642,643,645,646,647,1763,3586,3886,3887,3927,4274,4275,4278,4279,4420,4421,4422,4424,4428,4829,4830,4831,4832,4842,6168,6228,6229,6235,6243,6488,6489,6490,7361,7800,10439,11356,12203,12225,12236,12258,12902,13021,13596);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2154 WHERE `entry` IN (24683,24684,24686,24687,24688,24689,24690,24762,25565,25567,25568,25570,25572,25575,25576,25577);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2155 WHERE `entry` IN (24685,25569);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2156 WHERE `entry` IN (12803);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2157 WHERE `entry` IN (19389,21350);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2158 WHERE `entry` IN (18829);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2159 WHERE `entry` IN (8923,9217,9218,9219,9718,10263,10809,11467);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2160 WHERE `entry` IN (30385,31474);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2161 WHERE `entry` IN (17723,20164);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2162 WHERE `entry` IN (11663);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2163 WHERE `entry` IN (21346,21612);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2164 WHERE `entry` IN (23061,23261,23281,23282);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2165 WHERE `entry` IN (18731,20636);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2166 WHERE `entry` IN (22076);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2167 WHERE `entry` IN (17990,20189);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2168 WHERE `entry` IN (17796,20630);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2169 WHERE `entry` IN (8929,9025,9502,10076,14321,14323,14326);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2170 WHERE `entry` IN (12422);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2171 WHERE `entry` IN (10376,10596);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2172 WHERE `entry` IN (8983,9018,9019,9024,9027,9028,9029,9030,9031,9032,9033,9034,9035,9036,9037,9038,9039,9040,9041,9042,9056,9156,9196,9236,9237,9319,9537,9543,9568,9736,9938,10220,10268,10339,10363,10429,10430,10503,10509,10584,10812,11486,11487,11488,11489,11490,11492,11496,11501,12459,12461,12463,12464,14322,14324,14325,14327,14354,14502,14506,15229,15230,15233,15235,15236,15240,15246,15249,15250,15252,15262,15264,15277,15311,15312,16042,16080,16097);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2173 WHERE `entry` IN (11662,12460,12467);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2174 WHERE `entry` IN (17862,20521);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2175 WHERE `entry` IN (24238);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2176 WHERE `entry` IN (1840);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2177 WHERE `entry` IN (20901,20902,21610,21611);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2178 WHERE `entry` IN (21218,21221,21298,21299,21301,21339,21508);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2179 WHERE `entry` IN (20885,20886,21466,21467,21590,21599,21600,21624);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2180 WHERE `entry` IN (17826,17882,18105,20168,20183,20184);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2181 WHERE `entry` IN (33836,34218);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2182 WHERE `entry` IN (30245,30249,31750,31751);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2183 WHERE `entry` IN (33202,33398);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2184 WHERE `entry` IN (15516,32857,33694);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2185 WHERE `entry` IN (36272,36296,36565);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2186 WHERE `entry` IN (32916,33400);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2187 WHERE `entry` IN (12899);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2188 WHERE `entry` IN (16472);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2189 WHERE `entry` IN (929,1284,1748,2425,3974,3975,3976,3977,4542,4543,6487,7228,9095,10156,10162,10432,10433,10435,10436,10437,10438,10502,10504,10505,10506,10507,10508,10558,10808,10811,10813,10901,10942,10997,11032,11142,11261,11380,11439,11622,11946,11947,11948,11949,11978,11982,12129,12756,12804,13256,13419,14352,14507,14509,14510,14515,14517,14831,14834,14861,14988,15082,15083,15084,15085,15114,15192,15204,15205,15299,15302,15348,15362,15369,15370,15378,15379,15380,15381,15382,15410,15411,15412,15413,15427,15481,15491,15509,15510,15511,15514,15543,15544,15571,15608,15625,15628,15633,15667,15688,15776,15963,16077,16101,16102,16118,16128,16440,16524,16775,16776,16777,16778,16816,17008,17009,17010,17011,17012,17026,17076,17233,17354,17380,17381,17500,17521,17533,17534,17651,17772,17797,17798,17852,17874,17941,17942,17948,17949,17991,18040,18041,18060,18063,18075,18076,18141,18254,18338,18343,18344,18371,18373,18472,18601,18621,18624,18667,18728,18780,18932,19214,19556,19597,19604,19647,19893,19894,19895,20266,20268,20306,20318,20481,20629,20633,20637,20690,21003,21538,21768,21823,21845,21932,22409,22522,22605,22606,22627,22629,22641,22644,22996,23035,23054,23230,23426,23467,23499,23508);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2189 WHERE `entry` IN (23578,23759,23812,23863,23877,23878,23879,23880,23899,23912,23913,23914,23944,24143,24144,24239,24505,31055,31818,31819,31820,31821,31822,32918,32919,33399,33401,37243,37244,37283,37444);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2190 WHERE `entry` IN (15552);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2191 WHERE `entry` IN (11382,12017,15263,23576,23577);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2192 WHERE `entry` IN (37226);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2193 WHERE `entry` IN (2784,3057,3516,4949,4968,7937,7999,10181,10540,20888,21224,21227,22825,22826,22827,22828,22920);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2194 WHERE `entry` IN (16028,16800,16802,17468,19622,20906,21606,21964,22951,23419,23953,23954,23980,24200,24201,26529,26530,26532,26533,27389,27390,28684,29249,29268,29278,29305,29311,29315,29324,29373,29417,29446,29447,29448,29611,29615,29701,29718,29940,29955,29991,30057,30061,30452,30530,30549,30600,30601,30602,30603,30748,31125,31211,31212,31215,31217,31464,31507,31534,31612,31656,31657,31673,31674,31679,31680,31722,32273,32295,32313,32353,32368,32865,33147,33271,33350,33388,33449,33453,33515,33524,33846,33850,33851,33852,33985,33986,33988,33989,33993,33994,34015,34016,34057,34115,34152,34175,34496,34497,34780,35013,35143,35216,35268,35269,35347,35348,35349,35350,35351,35352,35359,35360,36064,36067,36476,36477,36494,36502,36612,36658,36723,36855,36938,37613,37627,37629,37677,37720,37813,37957,37958,37959,38106,38112,38113,38296,38297,38402,38433,38462,38482,38483,38582,38583,38599,38603);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2195 WHERE `entry` IN (15193);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2196 WHERE `entry` IN (20905,20910,20911,21588,21589,21618,21838);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2197 WHERE `entry` IN (24560,25560);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2198 WHERE `entry` IN (20896,21702);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2199 WHERE `entry` IN (11980,16807,16808,16809,17711,17734,18481,20039,20045,20046,20049,20187,20568,20596,20597,20864,20867,20868,20879,20880,21174,21303,21304,21591,21592,21593,21594,21595,21596,21608,21623,22330,22346,23397,24723,24744,25562,25573);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2200 WHERE `entry` IN (20036,20037,24664,24857);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2201 WHERE `entry` IN (25772);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2202 WHERE `entry` IN (4814);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2203 WHERE `entry` IN (329,2359,7031,7032,8324,14331);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2204 WHERE `entry` IN (16193);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2205 WHERE `entry` IN (11665,11672,12076,12099,12100,12101);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2206 WHERE `entry` IN (14401);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2207 WHERE `entry` IN (16336,16338);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2208 WHERE `entry` IN (15141);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2209 WHERE `entry` IN (11669);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2210 WHERE `entry` IN (11658,11659,11661,11671,11673,11988,12057,12098,12118,12259,12264,14081,14465,14466,14751,14752);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2211 WHERE `entry` IN (24722,25552);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2212 WHERE `entry` IN (14464);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2213 WHERE `entry` IN (10264);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2214 WHERE `entry` IN (15748,15751,15754,15758,15807,15810);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2215 WHERE `entry` IN (11664,15747,15753,15757,15812);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2216 WHERE `entry` IN (10516);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2217 WHERE `entry` IN (12465);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2218 WHERE `entry` IN (9499,12468,15247);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2219 WHERE `entry` IN (1842,5709,5710,5719,5720,5721,5722,7267,7271,7272,7275,7604,7795,7796,7797,8127,8443,11878,12018,15743,15744,15750,15806,15813,15814,15815,15816,15817,15818);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2220 WHERE `entry` IN (10184);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2221 WHERE `entry` IN (15286,15288,15290);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2222 WHERE `entry` IN (14662,14663,14664,14666);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2223 WHERE `entry` IN (14503);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2224 WHERE `entry` IN (22855);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2225 WHERE `entry` IN (17770,20169);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2226 WHERE `entry` IN (15689);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2227 WHERE `entry` IN (30084);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2228 WHERE `entry` IN (32187);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2229 WHERE `entry` IN (22056);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2230 WHERE `entry` IN (25588);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2231 WHERE `entry` IN (37698,39299,39300,39301);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2232 WHERE `entry` IN (22952,34815,35262);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2233 WHERE `entry` IN (21362);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2234 WHERE `entry` IN (33203,33376);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2235 WHERE `entry` IN (34147,34148);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2236 WHERE `entry` IN (17767,17808,17842,17888);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2237 WHERE `entry` IN (1853,12397,12435,15517,15589,15690,15727,17225,17535,17968,18341,18473,18708,18732,20267,20653,20657,20706,23574);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2238 WHERE `entry` IN (10340,10538,14020,15206,15207,15208,15220,15467,15740,15741,15742,18168,33052,33116);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2239 WHERE `entry` IN (25741);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2240 WHERE `entry` IN (15550,16152,18832,18834,18835,23682,23709,29306,29310,31368,31465,34796,35438);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2241 WHERE `entry` IN (27386,30178,30756,31448);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2242 WHERE `entry` IN (32877,33155);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2243 WHERE `entry` IN (10404,15687,15691,16151,16457,17096,17257,17281,17306,17308,17455,17536,17537,17848,17879,17880,17881,17975,17976,17977,17978,17980,18051,18055,18069,18096,18398,18399,18400,18401,18402,18432,18433,18434,18436,18805,18831,18945,19044,19218,19219,19220,19221,19516,19710,19781,19782,19783,20060,20062,20063,20064,20243,20531,20535,20737,20738,20745,21212,21213,21214,21215,21216,21217,21364,21369,21525,21526,21533,21536,21537,21551,21558,21559,21581,21582,21697,21698,21712,21875,21920,21958,21965,21966,22055,22119,22120,22140,22167,22841,22856,22871,22887,22898,22917,22947,22948,22949,22950,22997,23089,23191,23197,23375,23418,23420,23421,23469,23965,24850,24882,24891,24892,25038,25165,25166,25315,25502,25708,25840,26630,26631,26632,26668,26683,26684,26685,26686,26687,26693,26723,26731,26763,26794,26796,26798,26861,26893,26918,27447,27483,27654,27655,27656,27975,27977,27978,28132,28171,28546,28586,28587,28729,28730,28731,28859,28860,28921,28922,28923,29120,29266,29281,29304,29307,29308,29309,29312,29313,29314,29316,29573,29932,30114,30176,30397,30398,30449,30451,30510,30522,30529,30532,30540,30770,30772,30774,30775,30788,30790,30803,30807,30809,30810,31134,31311,31349,31350,31360,31362);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2243 WHERE `entry` IN (31365,31367,31370,31381,31384,31386,31441,31456,31469,31473,31506,31508,31509,31510,31511,31512,31520,31533,31535,31536,31537,31538,31558,31559,31560,31561,31592,31610,31611,31615,31616,31617,31672,31734,32845,32846,32867,32871,32872,32873,32874,32875,32876,32878,32882,32883,32885,32886,32904,32906,32907,32908,32913,32914,32915,32927,32930,32933,32934,32955,33070,33089,33113,33118,33121,33148,33149,33150,33151,33152,33153,33154,33156,33157,33158,33159,33161,33162,33163,33186,33190,33191,33228,33288,33293,33329,33344,33360,33385,33391,33392,33393,33432,33433,33567,33651,33670,33692,33693,33699,33700,33715,33716,33717,33718,33719,33720,33722,33723,33724,33756,33772,33773,33885,33888,33890,33909,33910,33911,33943,33954,33955,33959,33966,33967,33983,33984,33990,33995,34003,34004,34014,34035,34069,34071,34097,34106,34108,34109,34133,34134,34139,34141,34164,34165,34166,34171,34185,34197,34215,34221,34222,34226,34564,34566,34660,34797,34799,34800,34813,34825,34826,34928,34942,35028,35029,35030,35031,35032,35033,35034,35036,35037,35038,35039,35040,35041,35042,35043,35044,35045,35046,35047,35048,35049,35050,35051,35052,35119,35144,35263,35264,35265,35266,35267,35270,35271,35272,35278,35279);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2243 WHERE `entry` IN (35280,35311,35439,35440,35441,35442,35443,35447,35448,35449,35451,35490,35511,35512,35513,35514,35515,35516,35517,35518,35519,35520,35521,35522,35523,35524,35525,35527,35528,35529,35530,35531,35532,35533,35534,35535,35536,35537,35538,35539,35540,35541,35542,35543,35544,35615,35616,36135,36497,36498,36538,36597,36626,36627,36633,36678,36701,36789,36838,36839,36853,36897,36899,36939,36948,36950,36954,36957,36960,36961,36968,36969,36970,36971,36978,36982,37025,37098,37116,37117,37126,37182,37184,37215,37217,37227,37230,37488,37504,37505,37506,37531,37533,37534,37540,37562,37697,37833,37955,37970,37972,37973,38064,38103,38110,38123,38128,38129,38138,38139,38156,38157,38174,38219,38220,38256,38257,38258,38261,38262,38265,38266,38267,38369,38390,38399,38400,38401,38403,38404,38405,38406,38407,38408,38418,38431,38434,38435,38436,38444,38454,38490,38494,38549,38550,38585,38586,38602,38604,38637,38638,38639,38640,38675,38676,38677,38678,38679,38680,38681,38682,38683,38684,38685,38686,38687,38688,38689,38690,38691,38692,38693,38694,38699,38700,38701,38702,38758,38759,38760,38761,38769,38770,38771,38772,38775,38776,38777,38784,38785,39166,39167,39168,39190,39287,39288,39289,39302,39303,39304);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2243 WHERE `entry` IN (39305,39306,39307,39746,39747,39751,39805,39814,39815,39823,39863,39864,39899,39920,39922,39944,39945,40142,40143,40144,40145);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2244 WHERE `entry` IN (14862);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2245 WHERE `entry` IN (32926,32938,33352,33353,36980,38320,38321,38322);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2246 WHERE `entry` IN (15261);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2247 WHERE `entry` IN (20041,23394);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2248 WHERE `entry` IN (18503,20309);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2249 WHERE `entry` IN (36619,38233,38459,38460,38711,38712,38970,38971,38972,38973,38974,38975);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2250 WHERE `entry` IN (38028);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2251 WHERE `entry` IN (20870,20912,21601,21626);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2252 WHERE `entry` IN (17839,20744,21104,21140,21148,22170,22171,22172);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2253 WHERE `entry` IN (22128,22129);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2254 WHERE `entry` IN (23597);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2255 WHERE `entry` IN (24374);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2256 WHERE `entry` IN (2675,4277,8937);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2257 WHERE `entry` IN (16127);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2258 WHERE `entry` IN (16124);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2259 WHERE `entry` IN (16149);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2260 WHERE `entry` IN (16156,16157,16158);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2261 WHERE `entry` IN (11657,11677,12096,12097,13078,13079,13086,13088,13137,13138,13139,13143,13144,13145,13147,13152,13153,13154,13176,13179,13180,13181,13216,13218,13236,13257,13296,13297,13298,13299,13300,13318,13319,13320,13356,13357,13437,13438,13439,13441,13442,13447,13577,13597,13598,13616,13617,13797,13798);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2262 WHERE `entry` IN (16244,16360,16427,16983);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2263 WHERE `entry` IN (16150);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2264 WHERE `entry` IN (16022,16981);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2265 WHERE `entry` IN (16027,16164,16449);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2266 WHERE `entry` IN (16167);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2267 WHERE `entry` IN (16020);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2268 WHERE `entry` IN (16024);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2269 WHERE `entry` IN (16375);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2270 WHERE `entry` IN (16290);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2271 WHERE `entry` IN (16447);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2272 WHERE `entry` IN (16982,16984);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2273 WHERE `entry` IN (16036,16056,16057,16236,16297,16698,17055);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2274 WHERE `entry` IN (16037);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2275 WHERE `entry` IN (15318,15319,15320,15323,15324,15325,15336);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2276 WHERE `entry` IN (16034);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2277 WHERE `entry` IN (16428,16429);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2278 WHERE `entry` IN (16021,16165,16368,16448,16452);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2279 WHERE `entry` IN (16194,16215,16216);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2280 WHERE `entry` IN (16017,16018,16029);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2281 WHERE `entry` IN (11352,12159,14750,14762,14763,14764,14765,14766,14767,14768,14769,14770,14771,14772,14773,14774,14775,14776,14777,14943,14944,14945,14946,14947,14948,15327,15335,15338,15339,15340,15341,15343,15355,15385,15386,15388,15389,15390,15391,15392,15555,16062);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2282 WHERE `entry` IN (15928,15929,15930,15931,15932,15936,15952,15953,15954,15956,15989,15990,16011,16060,16061,16063,16064,16065);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2283 WHERE `entry` IN (16441);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2284 WHERE `entry` IN (16126);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2285 WHERE `entry` IN (15974,15975,16505,29274);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2286 WHERE `entry` IN (15980,15981,16506);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2287 WHERE `entry` IN (16573);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2288 WHERE `entry` IN (15976,15978,15979,16142,16453);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2289 WHERE `entry` IN (16243);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2290 WHERE `entry` IN (16387);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2291 WHERE `entry` IN (10440);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2292 WHERE `entry` IN (12119,15620,16168,16446);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2293 WHERE `entry` IN (13116,13117,14302,15047,15224,15922);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2294 WHERE `entry` IN (22250);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2295 WHERE `entry` IN (24175);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2296 WHERE `entry` IN (12900);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2297 WHERE `entry` IN (32357,32358,32471,32495,32501);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2298 WHERE `entry` IN (32386,32398,32400,32438);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2299 WHERE `entry` IN (11284);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2300 WHERE `entry` IN (15276);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2301 WHERE `entry` IN (2091,2108,2726,4339,4676,6073,7135,7136,7137,8608,8616,14668,15209,15438,17267,19203,19973,20703,21706,22323,25001,25417,28584,30416,30847,30983,31453);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2302 WHERE `entry` IN (12143);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2303 WHERE `entry` IN (2760,3417,4036,4037,4038,5893,5896,6521,7266,7738,9178,9878,9879);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2304 WHERE `entry` IN (2745,8281,8909,8910,8911,9026,9376);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2305 WHERE `entry` IN (14460);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2306 WHERE `entry` IN (2447);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2307 WHERE `entry` IN (9016,9017,9816);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2308 WHERE `entry` IN (11981,11983,14601);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2309 WHERE `entry` IN (7846,8680,15203);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2310 WHERE `entry` IN (575,5850,5852,6520,17003);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2311 WHERE `entry` IN (11502,11667,11668,12056,12265);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2312 WHERE `entry` IN (14461);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2313 WHERE `entry` IN (19551);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2314 WHERE `entry` IN (11583,13020);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2315 WHERE `entry` IN (19514);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2316 WHERE `entry` IN (11666);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2317 WHERE `entry` IN (832,2258,2592,2736,2752,2762,4034,4035,4499,4526,5898,5902,6239,8667,9377,9397,11576,11577,11578,11744,11745,11777,11778,11779,11783,11784,14399,14400,14478,15352,16043,17085,17154,17156,17157,17158,17159,17160,18062,18181,21707,22036,23029,26407,28411,28547,28585,28825,30418,30965,30970,30979,31452);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2318 WHERE `entry` IN (14455);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2319 WHERE `entry` IN (5855);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2320 WHERE `entry` IN (12237);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2321 WHERE `entry` IN (14435);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2322 WHERE `entry` IN (92);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2323 WHERE `entry` IN (2735,2791);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2324 WHERE `entry` IN (11321);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2325 WHERE `entry` IN (30258,31463);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2326 WHERE `entry` IN (14454);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2327 WHERE `entry` IN (12201);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2328 WHERE `entry` IN (14887,14888,14889,14890);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2329 WHERE `entry` IN (2761,2776,2794,3851,3861,3950,4978,5462,5894,5895,5897,6047,6220,6748,7132,7428,7429,8519,8520,8521,8522,8837,9453,10198,10642,11256,11862,12759,13278,13279,13322,13456,13696,13736,14269,14350,15211,16570,17153,17155,17167,17207,17358,19204,20704,21428,21728,22035,22309,24228,24601,25226,25514,25715,25755,25756,25757,26116,26178,26204,26214,26215,26216,26316,26340,26341,26342,30419,30846,31454,37994);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2330 WHERE `entry` IN (14458);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2331 WHERE `entry` IN (13282);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2332 WHERE `entry` IN (12876);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2333 WHERE `entry` IN (3917);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2334 WHERE `entry` IN (7079);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2335 WHERE `entry` IN (13280);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2336 WHERE `entry` IN (15305);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2337 WHERE `entry` IN (510,691,5461,10756,10757,10955);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2338 WHERE `entry` IN (14457);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2339 WHERE `entry` IN (22009);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2340 WHERE `entry` IN (25740,25865,26338,26339);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2341 WHERE `entry` IN (703,1043,1364,19206,20705);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2342 WHERE `entry` IN (6492,6550,11480,11483,11484,14397,15527,16530,16854,18864,18865,18866,18867,19205,20516,20702,22310,26370,30848);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2343 WHERE `entry` IN (10202);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2344 WHERE `entry` IN (10662);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2345 WHERE `entry` IN (10663);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2346 WHERE `entry` IN (10664);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2347 WHERE `entry` IN (6109);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2348 WHERE `entry` IN (21032);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2349 WHERE `entry` IN (7734,7735);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2350 WHERE `entry` IN (10485);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2351 WHERE `entry` IN (15275);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2352 WHERE `entry` IN (16491);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2353 WHERE `entry` IN (12457);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2354 WHERE `entry` IN (28912);
UPDATE `creature_template` SET `CreatureImmunitiesId`=2355 WHERE `entry` IN (8317);
