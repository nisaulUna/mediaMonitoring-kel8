-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2025 at 08:44 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `media_monitoring`
--

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE `keywords` (
  `id` int(11) NOT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keywords`
--

INSERT INTO `keywords` (`id`, `keyword`, `is_active`, `createdAt`) VALUES
(1, 'adidas', 1, '2025-04-17 15:40:21'),
(2, 'wardah', 1, '2025-04-17 15:40:39'),
(3, 'samsung', 1, '2025-04-17 15:55:26');

-- --------------------------------------------------------

--
-- Table structure for table `log_activities`
--

CREATE TABLE `log_activities` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `action_type` varchar(50) DEFAULT NULL,
  `action_details` text DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_mentions`
--

CREATE TABLE `media_mentions` (
  `id` int(11) NOT NULL,
  `id_keyword` int(11) DEFAULT NULL,
  `id_mediaSource` int(11) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `published_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `author` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media_mentions`
--

INSERT INTO `media_mentions` (`id`, `id_keyword`, `id_mediaSource`, `content`, `url`, `published_date`, `author`, `profile_image`) VALUES
(1, 1, 1, 'RT @KingKfeet: Light recovery run this morning, sockless, in my adidas. Have to leave the shoes outside because they smell 😅\n\n#footfetish #…', 'https://twitter.com/i/web/status/1912896339895005597', '2025-04-17 08:50:01', 'ShrunkenChris', 'https://pbs.twimg.com/profile_images/1903949779207421953/FWAv3IFU_normal.png'),
(2, 1, 1, 'RT @Im_GuguN: Biggest Ogle working with Adidas? 🥳🥳🔥🔥🔥\n\nAshley Ogle x Adidas ZA 🥳\nASHLEY CHILD OF GRACE \nASHLEY OGLE IS BLESSED\n#AshleyOgle…', 'https://twitter.com/i/web/status/1912896337575559454', '2025-04-17 08:50:01', 'JenniferNwank', 'https://pbs.twimg.com/profile_images/1905298246638931968/zZUjx6Jv_normal.jpg'),
(3, 1, 1, 'RT @FlyGirl5959: Ashley in a United kit🔥🔥🔥...GGMU for life🛑.....\n\nAshley X Adidas 💃\n\nASHLEY CHILD OF GRACE\nASHLEY OGLE IS BLESSED\n#AshleyOg…', 'https://twitter.com/i/web/status/1912896335985910209', '2025-04-17 08:50:01', 'Good_n3ss', 'https://pbs.twimg.com/profile_images/1884980912246386689/THqdoTpe_normal.jpg'),
(4, 1, 1, 'RT @SneakerNews: adidas Harden Vol. 9 \"Ice Metallic\" 🥶 🏀\n🚨 OFFICIAL IMAGES 🚨\n🗓️ May 10th, 2025\n💰 $160 https://t.co/YHKYRX0uuv', 'https://twitter.com/i/web/status/1912896334991892932', '2025-04-17 08:50:00', 'HennyHardaway96', 'https://pbs.twimg.com/profile_images/1905409032354992128/5_L6Fgq-_normal.jpg'),
(5, 1, 1, 'RT @GoodletB43638: Ashley’s and Adidas 🔥🤝.Go check out this reel on her IG 😍\n\nASHLEY CHILD OF GRACE \nASHLEY OGLE IS BLESSED\n#AshleyOgle \n#A…', 'https://twitter.com/i/web/status/1912896321310109832', '2025-04-17 08:49:57', 'wumiblessing7', 'https://pbs.twimg.com/profile_images/1514292569286529024/3xfN5JVJ_normal.png'),
(6, 1, 1, 'RT @FutureStacked: This is the youngest billionaire you’ve never heard of...\n\nHe was a pizza delivery boy who built Gymshark into a $1.3B c…', 'https://twitter.com/i/web/status/1912896311524995122', '2025-04-17 08:49:55', '1FlowState', 'https://pbs.twimg.com/profile_images/1815992897516470272/Qw5RneCO_normal.jpg'),
(7, 1, 1, 'RT @FuadCadani: Adidas have had their foot on Nike’s neck for over 12months now… please enough of the T90 astros with jeans and WAKE TF UP!', 'https://twitter.com/i/web/status/1912896306416177225', '2025-04-17 08:49:54', 'MoWelkin', 'https://pbs.twimg.com/profile_images/1818341682686939136/ZppD0p7N_normal.jpg'),
(8, 1, 1, 'RT @Somhiseremfcb: Agente de Adidas: \"Bienvenido a Champions Travel. ¿Adónde te gustaría ir?\"\n\nLamine Yamal: \"Milán, por favor.\" https://t.…', 'https://twitter.com/i/web/status/1912896301726921097', '2025-04-17 08:49:52', 'futboleste', 'https://pbs.twimg.com/profile_images/1912331141169758208/lbgViyvL_normal.jpg'),
(9, 1, 1, 'Ashley ogle X Adidas \n#Ashleyogle\n#Adidas\n\nGet innnnnn!!! https://t.co/mhgI9ZdcPm', 'https://twitter.com/i/web/status/1912896300913250334', '2025-04-17 08:49:52', 'bestofphalo', 'https://pbs.twimg.com/profile_images/1758668722351300608/NhO15iXR_normal.jpg'),
(10, 1, 1, 'RT @BarcaUniversal: Adidas agent: \"Welcome to champions travel. Where would you like to go?\"\n\nLamine Yamal: \"Milan please.\" https://t.co/j7…', 'https://twitter.com/i/web/status/1912896290175979744', '2025-04-17 08:49:50', 'thapajustin1', 'https://pbs.twimg.com/profile_images/1872297267069358080/11pl_q0g_normal.jpg'),
(11, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Did people forget about addias superstar?', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-14 21:44:31', '@aajjajaajajajajja-k6e', 'https://yt3.ggpht.com/ytc/AIdro_lVwICIdXFa1ZqPnlJnTv4SFfuRU1A_AODteTbyCBrRW5xHRe5Uim_mgvN8Z2GT4g_3fA=s48-c-k-c0x00ffffff-no-rj'),
(12, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Wow nice', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-14 11:04:03', '@Miracleshoes-t4x', 'https://yt3.ggpht.com/ytc/AIdro_m5evfCF_YxC_lDCZai6PdDPi8RLB_PVhrL3a1ARTLFBM2x9-KClsWFWW2FfUzwIrVBkQ=s48-c-k-c0x00ffffff-no-rj'),
(13, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: samba is so boring and ugly. I don‘t get the hype', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-12 04:24:27', '@mrqs83', 'https://yt3.ggpht.com/ytc/AIdro_nKWIczk1o26r8lgnkq_sGpeJkAaCThWoUQQHXqTGA=s48-c-k-c0x00ffffff-no-rj'),
(14, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: I have the white sambasa and love them. No issues with them.', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-12 03:56:30', '@moni1952', 'https://yt3.ggpht.com/ytc/AIdro_lks7HXNRgUTB2ngin3fc_yFQ82-k23iW2EPwaGgkY=s48-c-k-c0x00ffffff-no-rj'),
(15, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Definitely never been a Stan smith, samba fan. Not following the trend and hype..', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-09 18:57:10', '@priscillacarrillo4259', 'https://yt3.ggpht.com/ytc/AIdro_kZwIKmrpqZbBDzdKd3vQzjsMgnvHM3102MQxdoNf_P9vA=s48-c-k-c0x00ffffff-no-rj'),
(16, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Man the samba is the most uncomfortable shoe on the planet', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-04 10:27:04', '@BenTaylor-hq6cg', 'https://yt3.ggpht.com/ytc/AIdro_nYQvAmUyrYtkF2soc7ppz6IxaER9_xGSrVZLHiG4eUGMeY1Tl-U5nqn34h_UtOew4GdA=s48-c-k-c0x00ffffff-no-rj'),
(17, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Stan Smiths are so trash I don’t get the hype', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-03 15:01:38', '@About_a_Bag', 'https://yt3.ggpht.com/4ayCCdtDzuz2iq1OpMsAsXsU1cj3354O1NKns9nIScIHJj9l6HZd10ut7F6xSgvnHDGELvi2Ag=s48-c-k-c0x00ffffff-no-rj'),
(18, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: The AE1&#39;s are just a Yeezy rip off. Stole his designs.', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-02 15:10:53', '@Jimmy-es8bc', 'https://yt3.ggpht.com/ytc/AIdro_mqS2ojm7zY776HBwNXBXtdd3l_AO6DonPXU7uj6WjhzRZh=s48-c-k-c0x00ffffff-no-rj'),
(19, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Where are the &quot;Spezials?&quot;', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-02 13:12:26', '@richross4781', 'https://yt3.ggpht.com/8WOqEUN20oO_qJ7Bb2ZhPewF-jKFnOlzuOLJINmOdrSn9eUkVC6pLPt-ffdNvAJ39-1Q0H1TvWQ=s48-c-k-c0x00ffffff-no-rj'),
(20, 1, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Samba, Gazelle, Stan Smith, Spezial and SuperStar are lit. Not so much the Campus tho.', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-02 06:47:54', '@78nailbomb', 'https://yt3.ggpht.com/ytc/AIdro_nscva1mD467uqHBjZUgtqV9evH1nyvN1dEkQRwloE=s48-c-k-c0x00ffffff-no-rj'),
(21, 1, 3, 'In the Fall of 2023, adidas unleashed a beast with the Adizero Adios Pro Evo 1, a top-of-the-class running shoe that boasts a best-in-class...', 'https://sneakernews.com/2025/04/16/adidas-adizero-adios-pro-evo-1-dicks-sporting-goods/', '0000-00-00 00:00:00', 'Sneaker News', NULL),
(22, 1, 3, 'Adidas gave the classic Stan Smith tennis shoe an on-trend thin-sole update. Find details on the upcoming Stan Smith Low Pro release here.', 'https://footwearnews.com/shoes/sneaker-news/adidas-stan-smith-low-pro-1234799886/', '0000-00-00 00:00:00', 'Footwear News', NULL),
(23, 1, 3, 'adidas Originals x Brain Dead Hits the Tennis Court Once Again: This time delivering a full Spring/Summer 2025 collection, carried by a new...', 'https://hypebeast.com/2025/4/adidas-originals-x-brain-dead-collab-ss25-release-info', '0000-00-00 00:00:00', 'Hypebeast', NULL),
(24, 1, 3, 'Built for the streets! Kader\'s signature adidas Skateboarding pants are stylish and skate-ready in a new black colorway.', 'https://www.skateboarding.com/trending-news/kader-sylla-and-adidas-skateboarding-signature-pants', '0000-00-00 00:00:00', 'TransWorld SKATEboarding', NULL),
(25, 1, 3, 'Here\'s what you should get from Adidas for 25% off until April 22.', 'https://www.whowhatwear.com/fashion/shopping/adidas-spring-sale-2025', '0000-00-00 00:00:00', 'Who What Wear', NULL),
(26, 1, 3, 'adidas reveals the Samba Ruffle Stripes Pack in soft tones and silk detailing, releasing Summer 2025 for $120 USD.', 'https://sneakerbardetroit.com/adidas-samba-ruffle-stripes-pack-2025/', '0000-00-00 00:00:00', 'Sneaker Bar Detroit', NULL),
(27, 1, 3, 'Kith Is Back on the Pitch With adidas Football', 'https://hypebeast.com/2025/4/kith-adidas-football-collaboration-collection-release-info', '0000-00-00 00:00:00', 'Hypebeast', NULL),
(28, 1, 3, 'Zidane’s Legendary adidas Boot Is Back — But Way Softer', 'https://www.highsnobiety.com/p/adidas-kith-predator-megarise-2025/', '0000-00-00 00:00:00', 'Highsnobiety', NULL),
(29, 1, 3, 'Kith and Adidas Are Going All In on Soccer Style With Four Different Shoes', 'https://footwearnews.com/shoes/sneaker-news/kith-adidas-soccer-spring-2025-collection-release-date-1234799414/', '0000-00-00 00:00:00', 'Footwear News', NULL),
(30, 1, 3, 'Elisabeth Moss wore Adidas Superstar Sneakers like Jennifer Lawrence. Shop the chunky sneakers for spring at Nordstrom, Zappos, and Amazon.', 'https://www.instyle.com/elisabeth-moss-adidas-superstar-sneakers-11710338', '0000-00-00 00:00:00', 'InStyle', NULL),
(31, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Kecewa dengan wardah sudah beli mahal mahal wajah malah item ngak seperti wardah yg dulu,nga tahu apakah ada yg palsu ya', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2025-03-04 11:47:52', '@RisaArpiyani', 'https://yt3.ggpht.com/ytc/AIdro_lTsn_SEf4XL2vXIaaoqLUud5NQ9oq-8qVva6nli6qHfYKIw450e_k2BCXQMQ4EGZfOvw=s48-c-k-c0x00ffffff-no-rj'),
(32, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Maaf, saya beli Wardah Cristal secret serum, tidak memiliki pipa di dalam botol., jadinya kalau ditekan serumnya nggak keluar. Tolong di perhatikan dg baik, dimana kalian sdh memiliki nama besar. Saya merasa tidak puas. Terima kasih', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2024-12-23 15:50:28', '@mamamauapa5819', 'https://yt3.ggpht.com/ytc/AIdro_nWBkhs3XZcENi1MSPCdcXzpUjnMm2sZJbVobSifX-nvmmNb8bXfpOmj_RTnLGbL03qbA=s48-c-k-c0x00ffffff-no-rj'),
(33, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Ga sia aku pake wardah dri sampo sampai skincare ..terimaksih sdh undang halda &amp; jarayut', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2024-12-13 21:08:57', '@AnisyaZara', 'https://yt3.ggpht.com/ytc/AIdro_lImVEFshLCzwKPwsKil_wI44W3fLO5VgHisdM_-Jtm5ZMsPSMXFTRot9-tSU3zW38Ftw=s48-c-k-c0x00ffffff-no-rj'),
(34, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Rangkaian white secret yg cocok, kenapa hilang, sudah habis banyak uangku untuk coba2 yg lain 😭<br>Waktu beli skincare Korea yg ngerogoh kocek banyak. Tapi masih ga cocok', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2023-05-12 21:20:56', '@bobbyputra308', 'https://yt3.ggpht.com/ytc/AIdro_lZq10OLHFQkMAyZNp499RwwDRBh_ojjsGSpZmSFb__FiM=s48-c-k-c0x00ffffff-no-rj'),
(35, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Dulu saya pake wardah white secret cocok, tapi sekarang kenapa diganti dengan cristal secret. Sudah sy coba yg cristal secret, tapi ga cocok. Kenapa di ganti.<br>Sekarang susah cari yg cocok, udah coba some by me, jeju corcoal, yg mengandung pemutih juga pernah dicoba,  masker2an,  dan masih banyak lagi. Sekarang coba skintific, tapi masih ga cocok, masih teringat waktu make white secret dulu.<br>Pihak wardah 🙏', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2023-05-12 21:17:00', '@bobbyputra308', 'https://yt3.ggpht.com/ytc/AIdro_lZq10OLHFQkMAyZNp499RwwDRBh_ojjsGSpZmSFb__FiM=s48-c-k-c0x00ffffff-no-rj'),
(36, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Saya dl pke Wardah white secret,cocok,trs skrng ganti nama jd crystal,kenapa y pas hbis wudhu jd  putih,luntur.trs pedih d mata?', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-07-24 23:34:03', '@saepulgojali7048', 'https://yt3.ggpht.com/ytc/AIdro_lA7jr0LZvBQFLmBc7jijnVjyoazsJEdCveoYk4bFvSLqy3mJRIVzhAwp7IKIkTOUTl9A=s48-c-k-c0x00ffffff-no-rj'),
(37, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Alhamdulillah pemakaian rutin 1bulan ni bintik&amp;noda hitam bekas jerawatku memudar...love banget..tapi untuk mencerahkan masih belum ada hasil gak papa karna masih dapet 1bulan soale kalo skincare yg udah BPOM katax bakalan kelihatan hasilx pemakaian 6sampek 8bulan...harus telaten 😌....produk Wardah yg crystal secret ni memang bagus', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-06-29 05:26:22', '@sweatheart6874', 'https://yt3.ggpht.com/FgtwMcn8zLN_s7u12fJqGSPThGafpT-GELjfJWiPv2R6sO7TAzlzaka70tStt9xS9bnPduQ9dCU=s48-c-k-c0x00ffffff-no-rj'),
(38, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Old is better', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-06-06 20:36:21', '@mordecai891', 'https://yt3.ggpht.com/9Y1kXpYg1VxFteOmfsKIofeeiLzFXHFX5PtrL_Idz1_7r6pcu63Tc_UEeIV6AsuWGRl1gNbr5w=s48-c-k-c0x00ffffff-no-rj'),
(39, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Aman gk kk dipake ibu hamil', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-04-03 01:18:05', '@fentilolitabahri961', 'https://yt3.ggpht.com/ytc/AIdro_loYYdv_TIHbT9YfNb0RqCF0Lha75qltfmtu_X_7rxDaWM=s48-c-k-c0x00ffffff-no-rj'),
(40, 2, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Pliss jawab kak Wardah white secret itu boleh dipakai usia berapa ka?😫', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-01-15 23:34:36', '@rohmawatikhasanah4795', 'https://yt3.ggpht.com/ytc/AIdro_l-WPruEngifbfolAJ9ooMYouWRIljSLSUdcbFXhpBKLR2w067aQRcH7LDc0zzrTdX9yg=s48-c-k-c0x00ffffff-no-rj'),
(41, 2, 3, 'Wardah Inam: Overjet helps the dental industry address inefficiencies while improving patient communication. Our AI-powered platform analyzes...', 'https://datainnovation.org/2025/01/5-qs-for-wardah-inam-ceo-of-overjet/', '0000-00-00 00:00:00', 'Center for Data Innovation', NULL),
(42, 2, 3, 'Press release - HTF Market Intelligence Consulting Private Limited - Halal Sunscreen Market Growth Potential is Booming Now: Wardah,...', 'https://www.openpr.com/news/3961746/halal-sunscreen-market-growth-potential-is-booming-now-wardah', '0000-00-00 00:00:00', 'openPR.com', NULL),
(43, 2, 3, 'Our goal was to become the first objective standard for dentistry, by using AI to detect and quantify oral pathologies with more precision than...', 'https://pulse2.com/overjet-profile-wardah-inam-interview/', '0000-00-00 00:00:00', 'Pulse 2.0', NULL),
(44, 2, 3, 'Wardah\'s presence at Open Iftar London 2025 is proof that goodness knows no boundaries. From Indonesia to various parts of the world, Wardah...', 'https://www.prnewswire.co.uk/news-releases/kahf--wardah-support-open-iftar-london-2025-strengthening-global-brotherhood-302407307.html', '0000-00-00 00:00:00', 'PR Newswire UK', NULL),
(45, 2, 3, 'In conversation with MARKETING-INTERACTIVE, ParagonCorp said that the campaign celebrates women who go beyond expectations, particularly during...', 'https://www.marketing-interactive.com/wardah-s-campaign-with-paragoncorp-inspires-women-during-ramadan', '0000-00-00 00:00:00', 'Marketing-Interactive', NULL),
(46, 2, 3, 'Indonesia\'s Wardah surges past global giants like Vaseline, Dove, and Nivea to become Southeast Asia\'s top beauty brand in 2024.', 'https://www.campaignasia.com/article/top-10-beauty-brands-in-southeast-asia/498066', '0000-00-00 00:00:00', 'Campaign Asia', NULL),
(47, 2, 3, 'Wardah Inam is disrupting the dental industry. She is the cofounder and CEO of Overjet, a Boston-based startup that uses FDA-cleared artificial intelligence to...', 'https://www.bostonglobe.com/tech-power-players/year/2023/person/wardah-inam-overjet/', '0000-00-00 00:00:00', 'The Boston Globe', NULL),
(48, 2, 3, 'Wardah introduced its newest technology, namely Wardah Color Intelligence which is integrated with Beauty AI Personal Color.', 'https://voi.id/en/technology/460264', '0000-00-00 00:00:00', 'VOI.ID', NULL),
(49, 2, 3, 'Waridi Wardah is me embodying my expertise as a mentor, role model, public speaker, fashion project designer, model, and storyteller through my...', 'https://africa.businessinsider.com/local/lifestyle/revolutionizing-african-fashion-a-conversation-with-waridi-wardah/kldkfj0', '0000-00-00 00:00:00', 'Business Insider Africa', NULL),
(50, 2, 3, 'Living in a beautiful country like the UAE, where the spirit of Ramadan comes alive through stunning decorations, glowing lanterns and vibrant...', 'https://www.gulftoday.ae/culture/2025/03/02/radiance-of-ramadan-wardah-asad-reflects-on-art-and-the-holy-month', '0000-00-00 00:00:00', 'Gulf Today', NULL),
(51, 2, 3, 'A very dedicated wife and matriarch, she worked the family farm in Syria with her husband while raising their children. In the 1980s, she made the hard decision...', 'https://www.bcfh.com/obituaries/Wardah-Al-Hosry?obId=32518041', '0000-00-00 00:00:00', 'Bagnasco & Calcaterra Funeral Homes', NULL),
(52, 3, 1, 'RT @theKomixBro: LADY GAGA in 4K\nFrom COACHELLA\n4K MOBILE WALLPAPER\nfor iPhone &amp;📱 Samsung phones!\n\n📸 Kevin Mazur/Getty\n📱 4K | 1868  ×  3840…', 'https://twitter.com/i/web/status/1912898092052922691', '2025-04-17 08:56:59', 'victariano', 'https://pbs.twimg.com/profile_images/1912307294794072064/r2tnOB-r_normal.jpg'),
(53, 3, 1, 'RT @chiliimusk: 💲3⃣0️⃣ • 8⃣ Hours 🌵 \n\n🌵 RP &amp; Follow @Samsung_Chain\n\n[ AD - NFA - NPN - DYOR ]', 'https://twitter.com/i/web/status/1912898074500104571', '2025-04-17 08:56:55', 'moneyfesting31', 'https://pbs.twimg.com/profile_images/1898599596626223104/k09Eh1Wg_normal.jpg'),
(54, 3, 1, 'Check out Samsung Tv stand legs bn63-18575b 18576b UN50TU8000FXZA UN50TU8200FXZA Ship FASt https://t.co/it5lgKLA4v #eBay via @eBay', 'https://twitter.com/i/web/status/1912898069898678346', '2025-04-17 08:56:54', 'WholeSaleRemote', 'https://pbs.twimg.com/profile_images/866428270551506944/5OX26zX8_normal.jpg'),
(55, 3, 1, 'Samsung Galaxy S25 Ultra April International Flagship Phone Giveaway https://t.co/EFor0b6m6P', 'https://twitter.com/i/web/status/1912898048335974614', '2025-04-17 08:56:49', 'workwinsave', 'https://pbs.twimg.com/profile_images/1043250205720641537/I5Xt3qdJ_normal.jpg'),
(56, 3, 1, 'USB-C to Type C Color Cable For Apple iPhone 15 PD 60W Fast Charging For Huawei Xiaomi Samsung Type C Weaving Cable Accessories\nUSD USD 1.25 (47% off, USD USD 2.36)\n\nhttps://t.co/TKlumhrDL8\n#USB-C #USB-C #Audio #AliExpress', 'https://twitter.com/i/web/status/1912898043369918834', '2025-04-17 08:56:48', 'ai_shopper', 'https://pbs.twimg.com/profile_images/1826844356944560128/226JPHeb_normal.jpg'),
(57, 3, 1, '@DeepikaBhardwaj samsung a56', 'https://twitter.com/i/web/status/1912898042912735540', '2025-04-17 08:56:48', 'jointoaman', 'https://pbs.twimg.com/profile_images/1800412521129725953/aEgIbO19_normal.jpg'),
(58, 3, 1, 'RT @wtml0907: ✈️PRE #ENHYPEN 250413 Twitter X\n\n#HEESEUNG 168CM: Monotone Vintage Series Case ( -30~50%)\nJelly: 390 (มจ 190)\nTank: 450 (มจ 2…', 'https://twitter.com/i/web/status/1912898033349804314', '2025-04-17 08:56:45', 'jungwon081202', 'https://pbs.twimg.com/profile_images/1904104183755915264/vJwDxpnn_normal.jpg'),
(59, 3, 1, '@mr_cbillionaire Samsung brotherly', 'https://twitter.com/i/web/status/1912898029041967245', '2025-04-17 08:56:44', 'CObinna13856', 'https://pbs.twimg.com/profile_images/1777237760631246848/VHIJNE-Y_normal.png'),
(60, 3, 1, 'RT @jamedamanga: Gente, já escutei a gravação ao vivo no fone, na JBL, no Samsung pocket, no iPhone, no guitarrinha e no paredão… E nada… A…', 'https://twitter.com/i/web/status/1912898026894479416', '2025-04-17 08:56:44', 'lopslet', 'https://pbs.twimg.com/profile_images/1844044724186832896/bDBlDWhD_normal.jpg'),
(61, 3, 1, '@mr_cbillionaire Samsung always 😍❤️', 'https://twitter.com/i/web/status/1912897969067634706', '2025-04-17 08:56:30', 'IAMANONYMOUNS', 'https://pbs.twimg.com/profile_images/1882876496189980672/gAFJByiz_normal.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `media_sources`
--

CREATE TABLE `media_sources` (
  `id` int(11) NOT NULL,
  `source_name` varchar(100) DEFAULT NULL,
  `source_type` enum('news','social') DEFAULT NULL,
  `source_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `media_sources`
--

INSERT INTO `media_sources` (`id`, `source_name`, `source_type`, `source_url`, `is_active`) VALUES
(1, 'Twitter', 'social', 'https://twitter.com', 1),
(2, 'YouTube', 'social', 'https://youtube.com', 1),
(3, 'Google', 'news', 'https://news.google.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_keyword` int(11) DEFAULT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `id_user`, `id_keyword`, `project_name`, `is_active`, `createdAt`) VALUES
(1, 1, 1, 'project adidas', 1, '2025-04-17 15:40:21'),
(2, 1, 2, 'project wardah', 1, '2025-04-17 15:40:39'),
(3, 1, 2, 'project wardah2', 1, '2025-04-17 15:41:14'),
(4, 1, 3, 'project samsung', 1, '2025-04-17 15:55:26');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(11) NOT NULL,
  `id_project` int(11) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `report_type` enum('weekly','daily','monthly') DEFAULT NULL,
  `report_parameters` varchar(50) DEFAULT NULL,
  `report_data` text DEFAULT NULL,
  `generatedAt` datetime DEFAULT NULL,
  `expiresAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO reports (id, id_project, created_by, report_type, report_parameters, report_data, generatedAt, expiresAt) VALUES
(1, 1, 'Nisaul Husna', 'weekly', 'engagement,reach,sentiment', '{"engagement": 5200, "reach": 15000, "sentiment": "positive"}', '2025-04-12 10:30:00', '2025-05-12 10:30:00'),
(2, 1, 'Nisaul Husna', 'daily', 'clicks,impressions', '{"clicks": 450, "impressions": 3500}', '2025-04-18 09:15:00', '2025-04-25 09:15:00'),
(3, 2, 'Nisaul Husna', 'monthly', 'sales,revenue,engagement', '{"sales": 1250, "revenue": 87500, "engagement": 12800}', '2025-04-01 16:20:00', '2025-07-01 16:20:00'),
(4, 2, 'Intan Febyola', 'weekly', 'clicks,conversions', '{"clicks": 3200, "conversions": 480}', '2025-04-15 14:45:00', '2025-05-15 14:45:00'),
(5, 3, 'Karenina Malik', 'daily', 'views,comments,shares', '{"views": 1800, "comments": 320, "shares": 150}', '2025-04-19 08:00:00', '2025-04-26 08:00:00'),
(6, 4, 'Nisaul Husna', 'monthly', 'impressions,ctr,conversions', '{"impressions": 45000, "ctr": 3.2, "conversions": 1450}', '2025-03-31 11:30:00', '2025-06-30 11:30:00'),
(7, 4, 'Intan Febyola', 'weekly', 'engagement,mentions', '{"engagement": 7600, "mentions": 450}', '2025-04-14 13:20:00', '2025-05-14 13:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `sentiment_analysis`
--

CREATE TABLE `sentiment_analysis` (
  `id` int(11) NOT NULL,
  `id_mentions` int(11) DEFAULT NULL,
  `sentiment_score` decimal(5,2) DEFAULT NULL,
  `sentiment_category` enum('positive','negative','neutral') DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `analyzedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sentiment_analysis`
--

INSERT INTO `sentiment_analysis` (`id`, `id_mentions`, `sentiment_score`, `sentiment_category`, `language`, `analyzedAt`) VALUES
(1, 1, '-1.00', 'negative', 'en', '2025-04-17 18:40:46'),
(2, 2, '1.00', 'positive', 'en', '2025-04-17 18:40:46'),
(3, 3, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(4, 4, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(5, 5, '1.00', 'positive', 'en', '2025-04-17 18:40:46'),
(6, 6, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(7, 7, '1.00', 'positive', 'en', '2025-04-17 18:40:46'),
(8, 8, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(9, 9, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(10, 10, '4.00', 'positive', 'en', '2025-04-17 18:40:46'),
(11, 11, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(12, 12, '9.00', 'positive', 'en', '2025-04-17 18:40:46'),
(13, 13, '-1.00', 'negative', 'en', '2025-04-17 18:40:46'),
(14, 14, '4.00', 'positive', 'en', '2025-04-17 18:40:46'),
(15, 15, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(16, 16, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(17, 17, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(18, 18, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(19, 19, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(20, 20, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(21, 21, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(22, 22, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(23, 23, '-3.00', 'negative', 'en', '2025-04-17 18:40:46'),
(24, 24, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(25, 25, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(26, 26, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(27, 27, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(28, 28, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(29, 29, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(30, 30, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(31, 31, '-3.00', 'negative', 'id', '2025-04-17 18:40:46'),
(32, 32, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(33, 33, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(34, 34, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(35, 35, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(36, 36, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(37, 37, '2.00', 'positive', 'id', '2025-04-17 18:40:46'),
(38, 38, '2.00', 'positive', 'id', '2025-04-17 18:40:46'),
(39, 39, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(40, 40, '0.00', 'neutral', 'id', '2025-04-17 18:40:46'),
(41, 41, '4.00', 'positive', 'en', '2025-04-17 18:40:46'),
(42, 42, '1.00', 'positive', 'en', '2025-04-17 18:40:46'),
(43, 43, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(44, 44, '2.00', 'positive', 'en', '2025-04-17 18:40:46'),
(45, 45, '3.00', 'positive', 'en', '2025-04-17 18:40:46'),
(46, 46, '7.00', 'positive', 'en', '2025-04-17 18:40:46'),
(47, 47, '-2.00', 'negative', 'en', '2025-04-17 18:40:46'),
(48, 48, '3.00', 'positive', 'en', '2025-04-17 18:40:46'),
(49, 49, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(50, 50, '11.00', 'positive', 'en', '2025-04-17 18:40:46'),
(51, 51, '1.00', 'positive', 'en', '2025-04-17 18:40:46'),
(52, 52, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(53, 53, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(54, 54, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(55, 55, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(56, 56, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(57, 57, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(58, 58, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(59, 59, '0.00', 'neutral', 'en', '2025-04-17 18:40:46'),
(60, 60, NULL, NULL, 'other', '2025-04-17 18:40:46'),
(61, 61, NULL, NULL, 'other', '2025-04-17 18:40:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `password`) VALUES
(1, 'nisaul', 'Nisaul Husna', 'nisaul@example.com', 'password123'),
(2, 'intanf', 'Intan Febyola', 'intan@example.com', 'password123'),
(3, 'karenina', 'Karenina Malik', 'karenina@example.com', 'password123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_activities`
--
ALTER TABLE `log_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `media_mentions`
--
ALTER TABLE `media_mentions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_keyword` (`id_keyword`),
  ADD KEY `id_mediaSource` (`id_mediaSource`);

--
-- Indexes for table `media_sources`
--
ALTER TABLE `media_sources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_keyword` (`id_keyword`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_project` (`id_project`);

--
-- Indexes for table `sentiment_analysis`
--
ALTER TABLE `sentiment_analysis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mentions` (`id_mentions`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_mentions`
--
ALTER TABLE `media_mentions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `media_sources`
--
ALTER TABLE `media_sources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sentiment_analysis`
--
ALTER TABLE `sentiment_analysis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `log_activities`
--
ALTER TABLE `log_activities`
  ADD CONSTRAINT `log_activities_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `media_mentions`
--
ALTER TABLE `media_mentions`
  ADD CONSTRAINT `media_mentions_ibfk_1` FOREIGN KEY (`id_keyword`) REFERENCES `keywords` (`id`),
  ADD CONSTRAINT `media_mentions_ibfk_2` FOREIGN KEY (`id_mediaSource`) REFERENCES `media_sources` (`id`);

--
-- Constraints for table `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`id_keyword`) REFERENCES `keywords` (`id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`id_project`) REFERENCES `projects` (`id`);

--
-- Constraints for table `sentiment_analysis`
--
ALTER TABLE `sentiment_analysis`
  ADD CONSTRAINT `sentiment_analysis_ibfk_1` FOREIGN KEY (`id_mentions`) REFERENCES `media_mentions` (`id`);
COMMIT;

ALTER TABLE projects
ADD COLUMN deletedAt DATETIME NULL;

ALTER TABLE log_activities
MODIFY COLUMN action_type ENUM('login', 'logout', 'register', 'update_profile', 'delete_account', 'failed_login') DEFAULT NULL;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
