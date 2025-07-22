/* leaguedata is a local database used to store project data
leaguePatch is a table containing metrics for champions in patch 12.23
champions is a table containing metadata for all champions */

USE leaguedata;

-- transforming strings 'MID' and 'ADC' from Role column in leaguePatch to match how roles are listed in champions
UPDATE leaguePatch
SET Role =
	CASE Role
		WHEN 'MID' THEN 'MIDDLE'
		WHEN 'ADC' THEN 'BOTTOM'
		ELSE Role
END;

-- inner joining leaguePatch and champions using Name columns, transforming champions.Role values to UPPERCASE to match values in leaguePatch.Role
SELECT
	champions.Name,
    UPPER(champions.Role) AS ValidRoles,
    leaguePatch.Role AS PopRole,
    WRate,
    PickRate,
    RolePerc,
    BanPerc
FROM champions
INNER JOIN leaguePatch ON leaguePatch.Name = champions.Name;