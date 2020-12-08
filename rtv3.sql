-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2020 at 03:02 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vlserver`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `Name` text NOT NULL,
  `Kills` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL,
  `IP` text NOT NULL,
  `UID` text NOT NULL,
  `Pass` text NOT NULL,
  `Stealed` int(11) NOT NULL,
  `Sound` int(11) NOT NULL,
  `Level` int(11) NOT NULL,
  `TopSpree` int(11) NOT NULL,
  `Joins` int(11) NOT NULL,
  `UID2` text NOT NULL,
  `RPGBanTime` text NOT NULL,
  `MuteTime` int(11) NOT NULL,
  `Online` int(11) NOT NULL,
  `LA` text NOT NULL,
  `hide_admin` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `alias`
--

CREATE TABLE `alias` (
  `Name` varchar(25) NOT NULL,
  `IP` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `banned`
--

CREATE TABLE `banned` (
  `ban_nick` text NOT NULL,
  `ban_time` int(11) NOT NULL,
  `ban_exp` int(11) NOT NULL,
  `ban_reason` text NOT NULL,
  `admin_name` text NOT NULL,
  `ban_uid` text NOT NULL,
  `ban_uid2` text NOT NULL,
  `ban_ip` text NOT NULL,
  `Ctime_Banned` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mutes`
--

CREATE TABLE `mutes` (
  `mute_nick` text NOT NULL,
  `mute_time` int(11) NOT NULL,
  `mute_exp` int(11) NOT NULL,
  `mute_reason` text NOT NULL,
  `admin_name` text NOT NULL,
  `mute_uid` text NOT NULL,
  `mute_uid2` text NOT NULL,
  `mute_ip` text NOT NULL,
  `Ctime_Muted` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `panel_task`
--

CREATE TABLE `panel_task` (
  `ID` int(11) NOT NULL,
  `Type` text NOT NULL,
  `Param` text NOT NULL,
  `Param2` text NOT NULL,
  `Param3` text NOT NULL,
  `Param4` text NOT NULL,
  `Param5` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `playerstats`
--

CREATE TABLE `playerstats` (
  `Name` text NOT NULL,
  `Stubby` int(11) NOT NULL,
  `Shotgun` int(11) NOT NULL,
  `M4` int(11) NOT NULL,
  `Ruger` int(11) NOT NULL,
  `Spaz` int(11) NOT NULL,
  `RPG` int(11) NOT NULL,
  `Grenade` int(11) NOT NULL,
  `SMG` int(11) NOT NULL,
  `Sniper` int(11) NOT NULL,
  `M60` int(11) NOT NULL,
  `Chainsaw` int(11) NOT NULL,
  `Molotov` int(11) NOT NULL,
  `Heli` int(11) NOT NULL,
  `Head` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_account`
--

CREATE TABLE `rtv3_account` (
  `ID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `Password` text NOT NULL,
  `Joins` int(11) NOT NULL DEFAULT 0,
  `OriginIP` text NOT NULL,
  `IP` text NOT NULL,
  `UID` text NOT NULL,
  `UID2` text NOT NULL,
  `AdminLevel` int(11) NOT NULL DEFAULT 0,
  `Ban` text DEFAULT NULL,
  `Mute` text DEFAULT NULL,
  `RPGBan` text DEFAULT NULL,
  `DateReg` timestamp NOT NULL DEFAULT current_timestamp(),
  `DateLog` int(11) NOT NULL,
  `ReadNews` int(11) NOT NULL DEFAULT 0,
  `Sounds` int(11) NOT NULL DEFAULT 1,
  `Jingles` int(11) NOT NULL DEFAULT 1,
  `AutoRespawn` int(11) NOT NULL DEFAULT 0,
  `SpawnBan` int(11) NOT NULL DEFAULT 0,
  `RobberCoins` int(11) NOT NULL DEFAULT 0,
  `IsActivated` int(11) NOT NULL DEFAULT 1,
  `Comments` text DEFAULT 'no',
  `Stealth` int(11) NOT NULL DEFAULT 0,
  `IsOnline` int(11) NOT NULL,
  `ChatMode` varchar(255) NOT NULL DEFAULT 'old',
  `TeamESP` varchar(255) NOT NULL DEFAULT 'true',
  `Mapper` varchar(255) NOT NULL DEFAULT 'false',
  `MVPSound` int(11) NOT NULL DEFAULT 50043,
  `NoMVP` text NOT NULL DEFAULT 'false',
  `ShowCountry` text NOT NULL DEFAULT 'true',
  `ShowStats` text NOT NULL DEFAULT 'true',
  `AllowPM` text NOT NULL DEFAULT 'true',
  `NameHistory` text NOT NULL DEFAULT 'forodepl',
  `Ignore` text NOT NULL,
  `PublicChat` text NOT NULL DEFAULT 'true',
  `Taunt` text NOT NULL DEFAULT 'no',
  `ShowTaunt` text NOT NULL DEFAULT 'true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_adminlog`
--

CREATE TABLE `rtv3_adminlog` (
  `Date` int(11) NOT NULL,
  `Admin` int(11) NOT NULL,
  `AdminIP` text NOT NULL,
  `Cmd` text NOT NULL,
  `Target` int(11) NOT NULL,
  `Reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_bases`
--

CREATE TABLE `rtv3_bases` (
  `ID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `DefPos` text NOT NULL,
  `AttPos` text NOT NULL,
  `CheckpointPos` text NOT NULL,
  `VehicleModel` int(11) NOT NULL,
  `VehiclePos` text NOT NULL,
  `VehicleAngle` varchar(255) NOT NULL,
  `TopPlayer` int(11) DEFAULT 0,
  `Score` int(11) NOT NULL DEFAULT 0,
  `Author` int(11) NOT NULL DEFAULT 0,
  `BaseType` text NOT NULL DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rtv3_bases`
--

INSERT INTO `rtv3_bases` (`ID`, `Name`, `DefPos`, `AttPos`, `CheckpointPos`, `VehicleModel`, `VehiclePos`, `VehicleAngle`, `TopPlayer`, `Score`, `Author`, `BaseType`) VALUES
(1, 'Pueblo de los Banghos', '-1196.87, 372.487, 8.02279', '-1261.31, 194.207, 10.7683', '-1209.46, 84.9145, 14.6958', 175, '-1154.63, 294.576, 11.263', '2.3824', 0, 0, 0, 'default'),
(2, 'Haitian Drug Factory', '-1162.85,106.154,11', '-1026.74,82.0504,11.7', '-1027.64, 82.0749, 11.7461', 221, '-1121.81, 84.4702, 11.1264', '3.12103', 0, 0, 0, 'default'),
(3, 'Behind Cherry Popper', '-938.888, -610.984, 12.4282', '-971.715, -598.768, 11.4974', '-943.653, -531.388, 11.3902', 150, '-923.016, -524.873, 11.1572', '0.068934', 0, 0, 0, 'default'),
(4, 'Construction Yards', '331.163, -241.912, 29.6466', '274.079, -129.656, 18.3909', '272.481, -134.142, 11.8374', 211, '257.045, -296.172, 10.0935', '-0.19338', 0, 0, 0, 'default'),
(5, 'Sunshine Autos', '-967.501, -829.178, 6.80088', '-938.248, -957.829, 12.7327', '-909.615, -1037.27, 14.7913', 147, '-1017.75, -864.255, 17.9627', '-2.45527', 0, 0, 0, 'default'),
(6, 'Fullmoon Mall', '222.552, -919.209, 10.1874', '119.475,-997.951,10.9', '133.414,-997.562,10.6959', 141, '186.056, -875.088, 12.226', '1.16345', 0, 0, 0, 'default'),
(7, 'Cuban Garage', '-1133.24, -476.346, 10.8309', '-1081.35, -599.795, 11.3194', '-1100,-625.435,11.3107', 164, '-1046.53, -453.882, 11.0357', '-2.94366', 0, 0, 0, 'default'),
(8, 'Rock City', '-872.86, 692.13, 11.0846', '-824.129, 986.45, 11.0454', '-741.023, 1025.43, 11.0846', 188, '-877.917, 794.262, 10.9149', '-0.0211883', 0, 0, 0, 'default'),
(9, 'Spand Express', '355.631, -318.111, 11.8069', '164.43, -366.873, 11.6478', '153.976, -365.391, 8.67068', 213, '290.533, -305.551, 11.9591', '-1.60006', 0, 0, 0, 'default'),
(10, 'Beach Wars', '-215.685, -1639.48, 15.5355', '-439.164, -1702.68, 26.579', '-381.117, -1741.47, 8.02986', 154, '-306.306, -1657.34, 13.1576', '-3.13081', 0, 0, 0, 'default'),
(11, 'Vicepoint Loadingbay', '463.3, 287.938, 12.3319', '331.742, 363.284, 11.4745', '307.873, 376.468, 13.217', 151, '458.413, 332.047, 11.8341', '0.0589633', 0, 0, 0, 'default'),
(12, 'Elven City', '606.106, -1056.27, 50.1893', '559.464, -1149.32, 11.9895', '557.251, -1184.52, 12.0736', 154, '558.998, -1010.89, 11.1413', '3.06791', 0, 0, 0, 'default'),
(13, 'Construction Wars #2', '-230.775, -473.39, 177.413', '-348.194, -492.888, 170.093', '-377.256, -468.429, 170.628', 225, '-224.695, -488.404, 170.645', '-0.147169', 0, 0, 0, 'default'),
(14, 'Ruso bridge no existe', '-531.278, -775.118, 13.4846', '-397.98, -932.125, 23.7604', '-375.133, -933.584, 22.2877', 154, '-410.034, -770.291, 14.6741', '3.01345', 0, 0, 0, 'default'),
(15, 'Las Barrancas', '-773.491, 1435.7, 563.829', '-784.405, 1598.35, 577.157', '-752.224, 1634.87, 577.203', 220, '-815.706, 1458.79, 564.296', '1.51723', 0, 0, 0, 'default'),
(16, 'No Hay Escape', '585.542, -1261.33, 12.8361', '428.393, -1328.38, 23.5633', '418.874, -1355.11, 11.0712', 154, '575.637, -1414.4, 13.3061', '0.801229', 0, 0, 0, 'default'),
(17, 'Custom Base - Temple', '628.437, -1093.43, 776.981', '397.806, -1134.5, 772.004', '442.764, -1105.25, 775.176', 154, '556.68, -1131.81, 773.75', '1.23631', 0, 0, 0, 'default'),
(18, 'Fatty Bikers', '-574.469, 643.767, 11.0712', '-692.701, 747.789, 10.9149', '-692, 704.359, 12.1164', 188, '-563.473, 706.177, 20.5149', '1.54024', 0, 0, 0, 'default'),
(19, 'Leaf Links', '251.022, 501.271, 9.5805', '58.1338, 255.546, 19.432', '168.496, 241.373, 11.9211', 175, '148.53, 447.664, 12.8465', '-1.61866', 0, 0, 0, 'default'),
(20, 'Ship Wars', '642.425, -1834.43, 15.5901', '397.898, -1935.9, 15.5914', '391.19, -1742.58, 15.4609', 188, '632.27, -1798.06, 15.59', '1.77417', 0, 0, 0, 'default'),
(21, 'G-Spot Downtown', '-479.205, 949.745, 14.2165', '-584.534, 858.315, 11.5987', '-587.2, 840.033, 11.5987', 198, '-358.78, 990.747, 47.3406', '-0.181492', 0, 0, 0, 'default'),
(22, 'Abandoned Terminal', '-1807.68, -475.918, 14.363', '-1483.47, -483.804, 14.8673', '-1368.18, -543.907, 14.8672', 226, '-1677.07, -445.4, 14.8678', '1.31876', 0, 0, 0, 'default'),
(23, 'Vicepoint Helipad', '529.979, 219.674, 14.493', '294.022, 271.091, 17.71', '298.621, 299.905, 16.3396', 135, '549.331, 193.647, 16.0984', '0.440355', 0, 0, 0, 'default'),
(24, 'Washington Brawl', '128.993, -1104.71, 10.4466', '-121.803, -926.887, 10.4634', '-180.166, -977.574, 10.4633', 175, '38.6659, -1088.32, 10.4633', '1.55366', 0, 0, 0, 'default'),
(25, 'Pole Position Club', '206.909, -1395.94, 12.0664', '87.819, -1518.08, 10.4322', '64.1276, -1449.51, 10.5655', 198, '169.507, -1474.4, 10.8707', '-0.160016', 0, 0, 0, 'default'),
(26, 'Standing Vicepoint', '599.308, -192.883, 13.8289', '467.748, -17.5874, 10.7363', '464.029, -41.2394, 10.1495', 150, '544.771, -195.558, 13.829', '1.61406', 0, 0, 0, 'default'),
(27, 'Viceport Anarchy', '-1012.94, -1438.02, 11.6948', '-710.28, -1522.17, 11.8508', '-672.836, -1479.34, 13.5666', 175, '-962.862, -1393.1, 11.7809', '-0.39606', 0, 0, 0, 'default'),
(28, 'Roxor International', '-589.134, 1242.21, 11.0712', '-421.266, 1266.2, 11.767', '-448.337, 1299.84, 10.9043', 150, '-518.033, 1221.33, 8.81041', '2.58988', 0, 0, 0, 'default'),
(29, 'Junkyard V2', '-1336.06, 169.574, 11.2483', '-1163.01, 23.0408, 11.4965', '-1161.97, -13.3214, 16.3182', 150, '-1314.62, 165.641, 11.5229', '-3.03953', 0, 0, 0, 'default'),
(30, 'Havanna Colony', '-953.868, 30.5847, 10.5416', '-947.402, -263.423, 10.7803', '-994.138, -300.985, 10.7594', 164, '-1002, -6.32925, 12.3619', '-1.69632', 0, 0, 0, 'default'),
(31, 'North Point Brawl', '410.748, 587.559, 12.2567', '341.28, 751.484, 12.951', '250.632, 708.22, 12.9509', 207, '446.92, 610.745, 12.0566', '', 0, 0, 0, 'default'),
(32, 'North Point Skirmish', '431.212, 542.375, 11.6427', '309.707, 367.474, 13.217', '240.871, 301.773, 4.81753', 176, '330.454, 570.966, 4.7368', '', 0, 0, 0, 'default'),
(33, 'Behind Office Massacre', '-564.199, 921.597, 11.0846', '-575.272, 1072.7, 8.58371', '-527.657, 1028.96, 11.0768', 200, '-606.967, 922.456, 9.36121', '-0.0344191', 0, 0, 0, 'default'),
(34, 'Ammunation Roof', '-711.454, 1243.49, 15.8008', '-823.107, 1149.63, 12.4111', '-777.287, 1115.36, 9.85416', 147, '-647.929, 1259.48, 24.9883', '-3.12045', 0, 0, 0, 'default'),
(35, 'Phils Place', '-1103.66, 348.679, 11.6364', '-1041.37, 146.987, 11.263', '-999.261, 207.95, 11.4341', 188, '-1070.07, 302.562, 11.263', '-0.977257', 0, 0, 0, 'default'),
(36, 'Industrial Delivery', '-931.633, -1273.14, 11.8008', '-818.394, -1512.02, 12.1136', '-938.334, -1491.14, 12.1396', 228, '-867.8, -1336.32, 11.3597', '2.79544', 0, 0, 0, 'default'),
(37, 'Viceport Compund', '-1067.29, -1455.11, 11.7272', '-1034.09, -1264.98, 11.2803', '-1098.34, -1227.24, 11.2876', 154, '-1168.93, -1399.21, 11.267', '-1.9456', 0, 0, 0, 'default'),
(38, 'Airport Cargo', '-1429.09, -1291.5, 14.868', '-1250.07, -1242.21, 14.868', '-1236, -1271.52, 29.6993', 154, '-1370.05, -1255.69, 18.2095', '-2.42229', 0, 0, 0, 'default'),
(39, 'New town #2', '-1201.85, 1609.32, 7.80018', '-1112.22, 1699.15, 8.44461', '-1111.16, 1720.14, 7.80018', 154, '-1127.22, 1573.9, 7.80018', '0.0443902', 0, 0, 0, 'default'),
(40, 'Osgiliath Relic', '-2252.34, 880.058, 7.45918', '-2249.36, 523.131, 7.46918', '-2030.94, 750.337, 7.4192', 6400, '-2231.72, 698.406, 7.46918', '-1.54963', 0, 0, 0, 'default'),
(41, 'Print Works', '-1112.1, -165.648, 11.3773', '-884.994, -318.816, 11.1034', '-936.149, -201.133, 6.60072', 149, '-1086.51, -233.283, 11.4464', '-1.54522', 0, 0, 0, 'default'),
(42, 'Saurons Funeral', '-333.384, 1251.03, 11.4328', '-288.906, 1424.6, 11.4024', '-479.043, 1532.66, 9.54412', 172, '-371.437, 1321.59, 12.5491', '-1.60946', 0, 0, 0, 'default'),
(43, 'Rob the Pizza', '-673.79, 1501.06, 11.9767', '-599.344, 1379.08, 11.7668', '-513.506, 1367.71, 11.7669', 178, '-635.432, 1453.25, 12.0104', '-1.52777', 0, 0, 0, 'default'),
(44, 'Vercetti versus Mafia', '-257.99, -311.578, 10.2591', '-378.161, -560.71, 19.5742', '-358.165, -537.511, 12.779', 220, '-195.355, -408.303, 10.8943', '1.57475', 0, 0, 0, 'default'),
(45, 'Cams Can Opener', '-844.093, -1002.88, 12.0277', '-864.386, -634.811, 11.3756', '-858.023, -604.214, 11.1036', 147, '-846.834, -910.578, 11.1034', '-0.681769', 0, 0, 0, 'default'),
(46, 'Prawn Wars', '73.245, 1130.23, 17.8683', '-68.6318, 1003.16, 10.9403', '-81.7797, 914.771, 10.9401', 218, '-16.3354, 1209.81, 21.4526', '-3.13119', 0, 0, 0, 'default'),
(47, 'Area 51', '20.9902, 1070.13, 1013.69', '-0.61968, 978.837, 1013.64', '-16.6869, 916.985, 1009.07', 200, '83.7248, 1030.1, 1013.57', '-3.02822', 0, 0, 0, 'default'),
(48, 'Washington Villas', '87.8367, -554.58, 14.9863', '216.164, -412.681, 10.5571', '362.67, -512.205, 12.3246', 151, '128.406, -523.02, 13.7276', '-0.0796723', 0, 0, 0, 'default');

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_bases2`
--

CREATE TABLE `rtv3_bases2` (
  `ID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `DefPos` text NOT NULL,
  `AttPos` text NOT NULL,
  `CheckpointPos` text NOT NULL,
  `VehicleModel` int(11) NOT NULL,
  `VehiclePos` text NOT NULL,
  `VehicleAngle` varchar(255) NOT NULL,
  `TopPlayer` int(11) DEFAULT 0,
  `Score` int(11) NOT NULL DEFAULT 0,
  `Author` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_champ_rstats`
--

CREATE TABLE `rtv3_champ_rstats` (
  `Name` text NOT NULL,
  `Json` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_clan_ban`
--

CREATE TABLE `rtv3_clan_ban` (
  `Name` text NOT NULL,
  `Tag` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_doodle`
--

CREATE TABLE `rtv3_doodle` (
  `ID` int(11) NOT NULL,
  `Text` text NOT NULL,
  `Author` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rtv3_doodle`
--

INSERT INTO `rtv3_doodle` (`ID`, `Text`, `Author`) VALUES
(1, 'null', 0),
(2, 'null', 0),
(3, 'null', 0),
(4, 'null', 0),
(5, 'null', 0),
(6, 'null', 0),
(7, 'null', 0),
(8, 'null', 0),
(9, 'null', 0),
(10, 'null', 0),
(11, 'null', 0),
(12, 'null', 0),
(13, 'null', 0),
(14, 'null', 0),
(15, 'null', 0),
(16, 'null', 0),
(17, 'null', 0),
(18, 'null', 0),
(19, 'null', 0),
(20, 'null', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_msg`
--

CREATE TABLE `rtv3_msg` (
  `type` text NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rtv3_msg`
--

INSERT INTO `rtv3_msg` (`type`, `message`) VALUES
('', 'test'),
('from_ingame', 'dont_send'),
('from_discord', 'kiki:kockex  '),
('from_vl_ingame', 'FC **[MDt]Gogeta **: ok ');

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_objects`
--

CREATE TABLE `rtv3_objects` (
  `UID` text NOT NULL,
  `Model` int(11) NOT NULL,
  `Pos` text NOT NULL,
  `Euler` text NOT NULL,
  `Bases` int(11) NOT NULL,
  `LastEdited` int(11) NOT NULL,
  `LastEditTime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_panel_stuff`
--

CREATE TABLE `rtv3_panel_stuff` (
  `rtv3_mysql_timeout` text NOT NULL,
  `blacklisted_ip` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_pstats`
--

CREATE TABLE `rtv3_pstats` (
  `ID` int(11) NOT NULL,
  `Kills` int(11) NOT NULL DEFAULT 0,
  `Deaths` int(11) NOT NULL DEFAULT 0,
  `Assist` int(11) NOT NULL,
  `Stolen` int(11) NOT NULL DEFAULT 0,
  `AttWon` int(11) NOT NULL DEFAULT 0,
  `DefWon` int(11) NOT NULL DEFAULT 0,
  `MVP` int(11) NOT NULL DEFAULT 0,
  `TopSpree` int(11) NOT NULL DEFAULT 0,
  `WeaponInfo` text DEFAULT NULL,
  `Inventory` text DEFAULT NULL,
  `XP` int(11) NOT NULL DEFAULT 0,
  `Level` int(11) NOT NULL DEFAULT 0,
  `Playtime` int(11) NOT NULL,
  `ReadNews` text NOT NULL,
  `RoundPlayed` int(11) NOT NULL,
  `OperationScore` int(11) NOT NULL DEFAULT 0,
  `Missions` text NOT NULL,
  `DailyReward` int(11) DEFAULT 0,
  `Carcol1` int(11) NOT NULL DEFAULT 0,
  `Carcol2` int(11) NOT NULL DEFAULT 0,
  `LowestAverageFPS` int(11) NOT NULL DEFAULT 10000000,
  `HighestAveragePing` int(11) NOT NULL DEFAULT -1,
  `HighestAverageFPS` int(11) NOT NULL DEFAULT -1,
  `LowestAveragePing` int(11) NOT NULL DEFAULT 10000000,
  `LastFPS` int(11) DEFAULT 0,
  `LastPing` int(11) NOT NULL DEFAULT 0,
  `LastRes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_rstats`
--

CREATE TABLE `rtv3_rstats` (
  `Name` text NOT NULL,
  `Json` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_server`
--

CREATE TABLE `rtv3_server` (
  `ServPass` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_uid1`
--

CREATE TABLE `rtv3_uid1` (
  `UID` text NOT NULL,
  `Ban` text DEFAULT NULL,
  `Mute` text DEFAULT NULL,
  `RPGBan` text DEFAULT NULL,
  `Alias` text DEFAULT NULL,
  `Comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rtv3_uid2`
--

CREATE TABLE `rtv3_uid2` (
  `UID` text NOT NULL,
  `Ban` text DEFAULT NULL,
  `Mute` text DEFAULT NULL,
  `RPGBan` text DEFAULT NULL,
  `Alias` text DEFAULT NULL,
  `Comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `poster_time` int(11) NOT NULL,
  `body` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `panel_task`
--
ALTER TABLE `panel_task`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `rtv3_account`
--
ALTER TABLE `rtv3_account`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `rtv3_bases`
--
ALTER TABLE `rtv3_bases`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `rtv3_bases2`
--
ALTER TABLE `rtv3_bases2`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `panel_task`
--
ALTER TABLE `panel_task`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rtv3_account`
--
ALTER TABLE `rtv3_account`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rtv3_bases`
--
ALTER TABLE `rtv3_bases`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `rtv3_bases2`
--
ALTER TABLE `rtv3_bases2`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
