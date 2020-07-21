-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2020 at 06:47 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coadingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `Sr No` int(50) DEFAULT NULL,
  `Name` text NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone_No` varchar(20) NOT NULL,
  `mess` text NOT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`Sr No`, `Name`, `Email`, `Phone_No`, `mess`, `Date`) VALUES
(1, 'first post', 'firstpost@gmail.com', '123456789', 'first post', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `Sr No` int(11) NOT NULL,
  `Title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` text NOT NULL,
  `Content` text NOT NULL,
  `image_file` text NOT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`Sr No`, `Title`, `tagline`, `slug`, `Content`, `image_file`, `Date`) VALUES
(1, 'this is my first post ', 'coolpost', '', '', '0', '2020-07-18 10:31:44'),
(2, 'this is my second post', 'must read', 'A Jinja template is simply a text file. Jinja can generate any text-based format (HTML, XML, CSV, LaTeX, etc.). A Jinja template doesn’t need to have a specific extension: .html, .xml, or any other extension is just fine.\r\n\r\nA template contains variables and/or expressions, which get replaced with values when a template is rendered; and tags, which control the logic of the template. The template syntax is heavily inspired by Django and Python.\r\n\r\nBelow is a minimal template that illustrates a few basics using the default Jinja configuration. We will cover the details later in this document:', '', '0', '2020-07-18 10:35:06'),
(3, 'template', 'mstpost', '3-post', 'Template File Extension\r\nAs stated above, any file can be loaded as a template, regardless of file extension. Adding a .jinja extension, like user.html.jinja may make it easier for some IDEs or editor plugins, but is not required. Autoescaping, introduced later, can be applied based on file extension, so you’ll need to take the extra suffix into account in that case.\r\n\r\nAnother good heuristic for identifying templates is that they are in a templates folder, regardless of extension. This is a common layout for projects.', '', '2020-07-18 11:26:58'),
(4, 'variables', '4-post', '', 'Variables\r\nTemplate variables are defined by the context dictionary passed to the template.\r\n\r\nYou can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.\r\n\r\nYou can use a dot (.) to access attributes of a variable in addition to the standard Python __getitem__ “subscript” syntax ([]).\r\n\r\nThe following lines do the same thing:', '', '2020-07-18 11:27:43'),
(5, 'filter', '5-post', '', 'Filters\r\nVariables can be modified by filters. Filters are separated from the variable by a pipe symbol (|) and may have optional arguments in parentheses. Multiple filters can be chained. The output of one filter is applied to the next.\r\n\r\nFor example, {{ name|striptags|title }} will remove all HTML Tags from variable name and title-case the output (title(striptags(name))).\r\n\r\nFilters that accept arguments have parentheses around the arguments, just like a function call. For example: {{ listx|join(\', \') }} will join a list with commas (str.join(\', \', listx)).\r\n\r\nThe List of Builtin Filters below describes all the builtin filters.', '', '2020-07-18 11:28:21'),
(6, 'tests', '6-post', '6th post', 'Tests\r\nBeside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.\r\n\r\nTests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:', '', '2020-07-18 11:28:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`Sr No`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `Sr No` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
