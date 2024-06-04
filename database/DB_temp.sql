-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2024 at 10:21 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cee_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_acc`
--

CREATE TABLE `admin_acc` (
  `admin_id` int(11) NOT NULL,
  `admin_user` varchar(1000) NOT NULL,
  `admin_pass` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin_acc`
--

INSERT INTO `admin_acc` (`admin_id`, `admin_user`, `admin_pass`) VALUES
(1, 'admin@username', 'admin@password');

-- --------------------------------------------------------

--
-- Table structure for table `course_tbl`
--

CREATE TABLE `course_tbl` (
  `cou_id` int(11) NOT NULL,
  `cou_name` varchar(1000) NOT NULL,
  `cou_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `course_tbl`
--

INSERT INTO `course_tbl` (`cou_id`, `cou_name`, `cou_created`) VALUES
(71, 'SCIENCE', '2024-06-03 15:14:44');

-- --------------------------------------------------------

--
-- Table structure for table `examinee_tbl`
--

CREATE TABLE `examinee_tbl` (
  `exmne_id` int(11) NOT NULL,
  `exmne_fullname` varchar(1000) NOT NULL,
  `exmne_course` varchar(1000) NOT NULL,
  `exmne_gender` varchar(1000) NOT NULL,
  `exmne_birthdate` varchar(1000) NOT NULL,
  `exmne_year_level` varchar(1000) NOT NULL,
  `exmne_email` varchar(1000) NOT NULL,
  `exmne_password` varchar(1000) NOT NULL,
  `exmne_status` varchar(1000) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `examinee_tbl`
--

INSERT INTO `examinee_tbl` (`exmne_id`, `exmne_fullname`, `exmne_course`, `exmne_gender`, `exmne_birthdate`, `exmne_year_level`, `exmne_email`, `exmne_password`, `exmne_status`) VALUES
(9, 'Naresh', '71', 'male', '2000-03-22', 'fourth year', 'N@n', 'xxx', 'active'),
(10, 'Kanni', '71', 'male', '2010-02-10', 'first year', 'Kanni@mail.com', 'kanni', 'active'),
(12, 'Prithviraj', '71', 'male', '2024-06-14', 'third year', 'pp@ooo', 'admin@password', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `exam_answers`
--

CREATE TABLE `exam_answers` (
  `exans_id` int(11) NOT NULL,
  `axmne_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `exans_answer` varchar(1000) NOT NULL,
  `exans_status` varchar(1000) NOT NULL DEFAULT 'new',
  `exans_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `exam_answers`
--

INSERT INTO `exam_answers` (`exans_id`, `axmne_id`, `exam_id`, `quest_id`, `exans_answer`, `exans_status`, `exans_created`) VALUES
(333, 9, 34, 56, 'ML', 'new', '2024-05-23 14:25:22'),
(334, 9, 34, 55, 'hi', 'new', '2024-05-23 14:25:22'),
(337, 9, 35, 58, 'Time of flight is independent of mass because acceleration due to gravity is constant.', 'new', '2024-05-26 06:00:40'),
(338, 9, 35, 57, 'Average speed = Total distance / Total time = 15 km / (50/60) hr = 18 km/hr = 5  m/s', 'new', '2024-05-26 06:00:40'),
(339, 9, 36, 61, 'Average speed = Total distance / Total time = 15 km / (50/60) hr = 18 km/hr = 5  m/s', 'new', '2024-05-30 19:58:11'),
(340, 9, 36, 60, 'Speed', 'new', '2024-05-30 19:58:11'),
(341, 9, 36, 59, 'ML', 'new', '2024-05-30 19:58:11'),
(342, 9, 38, 66, 'First Law: Every body continues to be in its state of rest or of uniform motion in a straight line unless compelled by some external force to act otherwise. Second Law: The rate of change of momentum of a body is directly proportional to the applied force and takes place in the direction in which the force acts. Third Law: To every action, there is always an equal and opposite reaction.', 'new', '2024-06-03 15:39:41'),
(343, 9, 38, 63, 'Group of cells similar in origin and arrangement, specialized to perform a particular function. Examples include connective, epithelial, muscle and nerve tissues. ', 'new', '2024-06-03 15:39:41'),
(344, 9, 38, 64, 'A suspension is a heterogenous mixture in which the solute particles do not dissolve in the solvent, but remain suspended.  Properties include: Visible to naked eye, exhibit tyndall effect and settle when left undisturbed. Examples include muddy water, milk of magnesia, chalk in water etc.', 'new', '2024-06-03 15:39:41'),
(345, 9, 38, 65, 'Weight of the body is 100 N which implies that the mass is 10/g = 1 kg. Momentum, P = mv, hence, P = 1*20 = 20 kg-m/s', 'new', '2024-06-03 15:39:41'),
(346, 11, 38, 66, 'First Law: Every body continues to be in its state of rest or of uniform motion in a straight line unless compelled by some external force to act otherwise. Second Law: The rate of change of momentum of a body is directly proportional to the applied force and takes place in the direction in which the force acts. Third Law: To every action, there is always an equal and opposite reaction.', 'new', '2024-06-03 15:59:54'),
(347, 11, 38, 63, 'Group of cells similar in origin and arrangement, specialized to perform a particular function. Examples include connective', 'new', '2024-06-03 15:59:54'),
(348, 11, 38, 65, 'Weight of the body is 100 N which implies that the mass is 10/g = 1 kg. Momentum, P = mv, hence, P = 1*20 = 20 kg-m/s', 'new', '2024-06-03 15:59:54'),
(349, 11, 38, 64, 'A suspension is a heterogenous mixture in which the solute particles do not dissolve in the solvent, but remain suspended.  Properties include: Visible to naked eye, exhibit tyndall effect and settle when left undisturbed. Examples include muddy water, milk of magnesia, chalk in water etc.', 'new', '2024-06-03 15:59:54'),
(350, 10, 38, 65, 'Weight = Mass * gravity = Mass * 10 = 10 N, which implies Mass = 1 Kg. Momentum = Mass * Velocity = 1 * 20 = 20 kg-m/s. Answer = Momentum = 20 kg-m/s', 'new', '2024-06-03 16:23:52'),
(351, 10, 38, 66, 'First Law: A body continues to be in its state of rest or of uniform motion until and unless an external force acts on it.                                                                                                                                                                                   Second Law: The applied force is directly proportional to the rate of change of momentum for a body.                               Third Law: For every action, there is always an equal and opposite reaction.', 'new', '2024-06-03 16:23:52'),
(352, 10, 38, 64, 'A suspension is a heterogenous mixture. The solute particles doesnot dissolve in the solvent. The properties of suspension are, they are visible to Naked eye, they exhibit tyndall effect. Examples of suspension are : muddy water, chalk in water etc.', 'new', '2024-06-03 16:23:52'),
(353, 10, 38, 63, 'A tissue is a group of cells that perform a particular function. Eg :- Muscle, Nerve', 'new', '2024-06-03 16:23:52');

-- --------------------------------------------------------

--
-- Table structure for table `exam_attempt`
--

CREATE TABLE `exam_attempt` (
  `examat_id` int(11) NOT NULL,
  `exmne_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `examat_status` varchar(1000) NOT NULL DEFAULT 'used',
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `exam_attempt`
--

INSERT INTO `exam_attempt` (`examat_id`, `exmne_id`, `exam_id`, `examat_status`, `score`) VALUES
(61, 12, 38, 'used', 18),
(63, 9, 35, 'used', 0),
(64, 9, 36, 'used', 18),
(65, 9, 38, 'used', 20),
(67, 10, 38, 'used', 15);

-- --------------------------------------------------------

--
-- Table structure for table `exam_question_tbl`
--

CREATE TABLE `exam_question_tbl` (
  `eqt_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `exam_question` varchar(1000) NOT NULL,
  `exam_ch1` varchar(1000) NOT NULL,
  `exam_ch2` varchar(1000) NOT NULL,
  `exam_ch3` varchar(1000) NOT NULL,
  `exam_ch4` varchar(1000) NOT NULL,
  `exam_answer` varchar(1000) NOT NULL,
  `exam_status` varchar(1000) NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `exam_question_tbl`
--

INSERT INTO `exam_question_tbl` (`eqt_id`, `exam_id`, `exam_question`, `exam_ch1`, `exam_ch2`, `exam_ch3`, `exam_ch4`, `exam_answer`, `exam_status`) VALUES
(55, 34, 'Hi', '', '', '', '', 'hi', 'active'),
(56, 34, 'Machine Learning', '', '', '', '', 'Machine Learning', 'active'),
(57, 35, 'Hi', '10', '', '', 'Final answer - 8, Steps - 1', 'Average speed = Total distance / Total time = 15 km / (50/60) hr = 15 km / (5/6) hr  = 18 km/hr = 18 * 1000 / 3600 m/s = 5 m/s', 'active'),
(58, 35, 'Hello', '15', '', '', 'Keywords - 12, Fluency - 3', ' The time of flight is independent of mass because the acceleration due to gravity is constant for all objects, regardless of their masses.', 'active'),
(59, 36, 'Field of AI', '10', '', '', '', 'Machine Learning', 'active'),
(60, 36, 'Which of the following is a vector quantity?', '10', '', '', 'Correct answer', 'Velocity', 'active'),
(61, 36, ' A cyclist travels a distance of 15 km in 50 minutes. Calculate the average speed in m/s.', '10', '', '', 'steps - 5 marks, final answer - 5 marks', 'Average speed = Total distance / Total time = 15 km / (50/60) hr = 15 km / (5/6) hr  = 18 km/hr = 18 * 1000 / 3600 m/s = 5 m/s', 'active'),
(63, 38, 'What is a tissue?', '5', '', '', 'Definition, example', 'Group of cells similar in origin and arrangement, specialized to perform a particular function. Examples include connective, epithelial, muscle and nerve tissues. ', 'active'),
(64, 38, 'What is a suspension, what are its properties? Give an example of a suspension.', '5', '', '', 'Definition, example, properties', 'A suspension is a heterogenous mixture in which the solute particles do not dissolve in the solvent, but remain suspended.  Properties include: Visible to naked eye, exhibit tyndall effect and settle when left undisturbed. Examples include muddy water, milk of magnesia, chalk in water etc.', 'active'),
(65, 38, 'What is the momentum of a ball of weight 10 N, moving with a velocity of 20 m/s.', '5', '', '', 'Formula, dimensions of final answer', 'Weight of the body is 100 N which implies that the mass is 10/g = 1 kg. Momentum, P = mv, hence, P = 1*20 = 20 kg-m/s', 'active'),
(66, 38, 'State the three Newtons Laws of motion.', '5', '', '', 'Definitions', 'First Law: Every body continues to be in its state of rest or of uniform motion in a straight line unless compelled by some external force to act otherwise. Second Law: The rate of change of momentum of a body is directly proportional to the applied force and takes place in the direction in which the force acts. Third Law: To every action, there is always an equal and opposite reaction.', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `exam_tbl`
--

CREATE TABLE `exam_tbl` (
  `ex_id` int(11) NOT NULL,
  `cou_id` int(11) NOT NULL,
  `ex_title` varchar(1000) NOT NULL,
  `ex_time_limit` varchar(1000) NOT NULL,
  `ex_questlimit_display` int(11) NOT NULL,
  `ex_description` varchar(1000) NOT NULL,
  `ex_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `exam_tbl`
--

INSERT INTO `exam_tbl` (`ex_id`, `cou_id`, `ex_title`, `ex_time_limit`, `ex_questlimit_display`, `ex_description`, `ex_created`) VALUES
(38, 71, 'Quiz 1', '10', 4, 'Quiz 1', '2024-06-03 15:22:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_acc`
--
ALTER TABLE `admin_acc`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `course_tbl`
--
ALTER TABLE `course_tbl`
  ADD PRIMARY KEY (`cou_id`);

--
-- Indexes for table `examinee_tbl`
--
ALTER TABLE `examinee_tbl`
  ADD PRIMARY KEY (`exmne_id`);

--
-- Indexes for table `exam_answers`
--
ALTER TABLE `exam_answers`
  ADD PRIMARY KEY (`exans_id`);

--
-- Indexes for table `exam_attempt`
--
ALTER TABLE `exam_attempt`
  ADD PRIMARY KEY (`examat_id`);

--
-- Indexes for table `exam_question_tbl`
--
ALTER TABLE `exam_question_tbl`
  ADD PRIMARY KEY (`eqt_id`);

--
-- Indexes for table `exam_tbl`
--
ALTER TABLE `exam_tbl`
  ADD PRIMARY KEY (`ex_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_acc`
--
ALTER TABLE `admin_acc`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `course_tbl`
--
ALTER TABLE `course_tbl`
  MODIFY `cou_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `examinee_tbl`
--
ALTER TABLE `examinee_tbl`
  MODIFY `exmne_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `exam_answers`
--
ALTER TABLE `exam_answers`
  MODIFY `exans_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=354;

--
-- AUTO_INCREMENT for table `exam_attempt`
--
ALTER TABLE `exam_attempt`
  MODIFY `examat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `exam_question_tbl`
--
ALTER TABLE `exam_question_tbl`
  MODIFY `eqt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `exam_tbl`
--
ALTER TABLE `exam_tbl`
  MODIFY `ex_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
