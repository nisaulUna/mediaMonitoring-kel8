-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 20 Apr 2025 pada 16.55
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.0.25

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
-- Struktur dari tabel `email_settings`
--

CREATE TABLE `email_settings` (
  `id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `purpose` enum('RESET_PASSWORD','NOTIFICATION','WELCOME_EMAIL') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `keywords`
--

CREATE TABLE `keywords` (
  `id` int(11) NOT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `keywords`
--

INSERT INTO `keywords` (`id`, `keyword`, `is_active`, `createdAt`) VALUES
(1, 'wardah', 1, '2025-04-20 07:18:56'),
(2, 'adidas', 1, '2025-04-20 07:44:04'),
(3, 'nike', 1, '2025-04-20 07:48:34'),
(4, 'indomie', 1, '2025-04-20 07:50:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_activities`
--

CREATE TABLE `log_activities` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `action_type` enum('login','logout','register','update_profil') DEFAULT NULL,
  `action_details` text DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `log_activities`
--

INSERT INTO `log_activities` (`id`, `id_user`, `action_type`, `action_details`, `createdAt`) VALUES
(1, 1, 'register', '{\"ip\":\"::1\",\"userAgent\":\"PostmanRuntime/7.43.3\",\"username\":\"una\",\"email\":\"nisaulHusnaaa@email.com\"}', '2025-04-20 07:21:15'),
(2, 2, 'register', '{\"ip\":\"::1\",\"userAgent\":\"PostmanRuntime/7.43.3\",\"username\":\"intan\",\"email\":\"intanFeb@email.com\"}', '2025-04-20 07:21:45'),
(3, 3, 'register', '{\"ip\":\"::1\",\"userAgent\":\"PostmanRuntime/7.43.3\",\"username\":\"karenina\",\"email\":\"kareninaMalik@email.com\"}', '2025-04-20 07:22:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `media_mentions`
--

CREATE TABLE `media_mentions` (
  `id` int(11) NOT NULL,
  `id_keyword` int(11) DEFAULT NULL,
  `id_mediaSource` int(11) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `published_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `author` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `media_mentions`
--

INSERT INTO `media_mentions` (`id`, `id_keyword`, `id_mediaSource`, `content`, `url`, `published_date`, `author`, `profile_image`) VALUES
(1, 1, 1, '@biteflux Aku penasaran timephoria malah! Warnanya bagus sih menurutku —si wardah', 'https://twitter.com/i/web/status/1913858241068781910', '2025-04-20 00:32:17', 'Liberatied', 'https://pbs.twimg.com/profile_images/1905666027251531777/besd1BMI_normal.jpg'),
(2, 1, 1, 'RT @goodlucksofea: Henloo girls! If you’re coming to the Wardah Event, don’t forget to check the RSVP link in my last tweet.\n\nIt’s not waji…', 'https://twitter.com/i/web/status/1913858165306954006', '2025-04-20 00:31:59', 'kakgojesagain', 'https://pbs.twimg.com/profile_images/1878381062193311744/JxmDoWDw_normal.jpg'),
(3, 1, 1, 'kakak kakak mau tanya dong, aku kan pake cushion somethinc shade eclair, sekarang mau coba wardah lightning liquid foundation itu shade yg paling mendekati apa ya?, tia (⁠ ⁠◜⁠‿⁠◝⁠ ⁠)⁠♡', 'https://twitter.com/i/web/status/1913858108767494325', '2025-04-20 00:31:45', 'vouzmevoiyage', 'https://pbs.twimg.com/profile_images/1833490300968521728/02p_PP8e_normal.jpg'),
(4, 1, 1, '@sotomatcha Skin type: Normal to dry\n\n1st cleanser: Cleansing Oil Hadalabo\nFace wash: Wardah Hydra Rose\nMoist: Skin Game Kind Moisturizer \nSunscreen: Somethinc Holyshield', 'https://twitter.com/i/web/status/1913858079609045385', '2025-04-20 00:31:38', 'Ichafaaizah', 'https://pbs.twimg.com/profile_images/1895051362301259776/vWf13Bkm_normal.jpg'),
(5, 1, 1, 'wardah moist dew tint 50k, ready all shade, minat? dm https://t.co/Z884EGQmhD', 'https://twitter.com/i/web/status/1913858000156348756', '2025-04-20 00:31:19', 'fluysho', 'https://pbs.twimg.com/profile_images/1908172723622432768/4h1KgR0M_normal.jpg'),
(6, 1, 1, '@tanyarlfes fw wardah acnederm, toner hadalabo ijo,aku pakai dua produk itu, sekitar 2bulanan udah membaik, kadang aku pakai mediklin ungu juga', 'https://twitter.com/i/web/status/1913857909408383299', '2025-04-20 00:30:58', 'nerowoul', 'https://pbs.twimg.com/profile_images/1793837398788542464/vCsqHaP3_normal.jpg'),
(7, 1, 1, '@sotomatcha skin type : oily skin\n\n1st cleanser : miceller water wardah yg botol hijau\nface wash : shinzui whitening \nmoist : SKINMURCH / skingame \nsunscreen: Wardah orange spf 30', 'https://twitter.com/i/web/status/1913857628465430557', '2025-04-20 00:29:51', 'sptihpsriaa', 'https://pbs.twimg.com/profile_images/1898964155048308736/70hGbwSz_normal.jpg'),
(8, 1, 1, '@womanfeeds_id Type kulit : combi\nMisellar water : g2g\nFacial wash : acnaway\nToner : skin1004\nSerum : skin1004\nMoisturizer : skin1004/somethinc\nSunscreen : wardah', 'https://twitter.com/i/web/status/1913857267323322581', '2025-04-20 00:28:24', 'tjutatika', 'https://pbs.twimg.com/profile_images/1852295159842779136/Kxuk-oHm_normal.jpg'),
(9, 1, 1, '@womanfeeds_id type kulit: combi to oily acne prone \nmw: somethinc calm down\nfw: acnaway \ntoner:-\nserum: harlette, forebie, somebymi yuja\nmoist: snail mucin cosrx \nss: wardah acne spf35', 'https://twitter.com/i/web/status/1913857162289549786', '2025-04-20 00:27:59', 'curskiddes', 'https://pbs.twimg.com/profile_images/1899332601740939264/TFpvHMO5_normal.jpg'),
(10, 1, 1, 'RT @goodlucksofea: Henloo girls! If you’re coming to the Wardah Event, don’t forget to check the RSVP link in my last tweet.\n\nIt’s not waji…', 'https://twitter.com/i/web/status/1913857133738668471', '2025-04-20 00:27:53', 'middlepipol2', 'https://pbs.twimg.com/profile_images/1786687085975584768/rIldVGdc_normal.jpg'),
(11, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Kecewa dengan wardah sudah beli mahal mahal wajah malah item ngak seperti wardah yg dulu,nga tahu apakah ada yg palsu ya', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2025-03-04 11:47:52', '@RisaArpiyani', 'https://yt3.ggpht.com/ytc/AIdro_lTsn_SEf4XL2vXIaaoqLUud5NQ9oq-8qVva6nli6qHfYKIw450e_k2BCXQMQ4EGZfOvw=s48-c-k-c0x00ffffff-no-rj'),
(12, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Maaf, saya beli Wardah Cristal secret serum, tidak memiliki pipa di dalam botol., jadinya kalau ditekan serumnya nggak keluar. Tolong di perhatikan dg baik, dimana kalian sdh memiliki nama besar. Saya merasa tidak puas. Terima kasih', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2024-12-23 15:50:28', '@mamamauapa5819', 'https://yt3.ggpht.com/ytc/AIdro_nWBkhs3XZcENi1MSPCdcXzpUjnMm2sZJbVobSifX-nvmmNb8bXfpOmj_RTnLGbL03qbA=s48-c-k-c0x00ffffff-no-rj'),
(13, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Ga sia aku pake wardah dri sampo sampai skincare ..terimaksih sdh undang halda &amp; jarayut', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2024-12-13 21:08:57', '@AnisyaZara', 'https://yt3.ggpht.com/ytc/AIdro_lImVEFshLCzwKPwsKil_wI44W3fLO5VgHisdM_-Jtm5ZMsPSMXFTRot9-tSU3zW38Ftw=s48-c-k-c0x00ffffff-no-rj'),
(14, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Rangkaian white secret yg cocok, kenapa hilang, sudah habis banyak uangku untuk coba2 yg lain 😭<br>Waktu beli skincare Korea yg ngerogoh kocek banyak. Tapi masih ga cocok', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2023-05-12 21:20:56', '@bobbyputra308', 'https://yt3.ggpht.com/ytc/AIdro_lZq10OLHFQkMAyZNp499RwwDRBh_ojjsGSpZmSFb__FiM=s48-c-k-c0x00ffffff-no-rj'),
(15, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Dulu saya pake wardah white secret cocok, tapi sekarang kenapa diganti dengan cristal secret. Sudah sy coba yg cristal secret, tapi ga cocok. Kenapa di ganti.<br>Sekarang susah cari yg cocok, udah coba some by me, jeju corcoal, yg mengandung pemutih juga pernah dicoba,  masker2an,  dan masih banyak lagi. Sekarang coba skintific, tapi masih ga cocok, masih teringat waktu make white secret dulu.<br>Pihak wardah 🙏', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2023-05-12 21:17:00', '@bobbyputra308', 'https://yt3.ggpht.com/ytc/AIdro_lZq10OLHFQkMAyZNp499RwwDRBh_ojjsGSpZmSFb__FiM=s48-c-k-c0x00ffffff-no-rj'),
(16, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Saya dl pke Wardah white secret,cocok,trs skrng ganti nama jd crystal,kenapa y pas hbis wudhu jd  putih,luntur.trs pedih d mata?', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-07-24 23:34:03', '@saepulgojali7048', 'https://yt3.ggpht.com/ytc/AIdro_lA7jr0LZvBQFLmBc7jijnVjyoazsJEdCveoYk4bFvSLqy3mJRIVzhAwp7IKIkTOUTl9A=s48-c-k-c0x00ffffff-no-rj'),
(17, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Alhamdulillah pemakaian rutin 1bulan ni bintik&amp;noda hitam bekas jerawatku memudar...love banget..tapi untuk mencerahkan masih belum ada hasil gak papa karna masih dapet 1bulan soale kalo skincare yg udah BPOM katax bakalan kelihatan hasilx pemakaian 6sampek 8bulan...harus telaten 😌....produk Wardah yg crystal secret ni memang bagus', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-06-29 05:26:22', '@sweatheart6874', 'https://yt3.ggpht.com/FgtwMcn8zLN_s7u12fJqGSPThGafpT-GELjfJWiPv2R6sO7TAzlzaka70tStt9xS9bnPduQ9dCU=s48-c-k-c0x00ffffff-no-rj'),
(18, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Old is better', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-06-06 20:36:21', '@mordecai891', 'https://yt3.ggpht.com/9Y1kXpYg1VxFteOmfsKIofeeiLzFXHFX5PtrL_Idz1_7r6pcu63Tc_UEeIV6AsuWGRl1gNbr5w=s48-c-k-c0x00ffffff-no-rj'),
(19, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Aman gk kk dipake ibu hamil', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-04-03 01:18:05', '@fentilolitabahri961', 'https://yt3.ggpht.com/ytc/AIdro_loYYdv_TIHbT9YfNb0RqCF0Lha75qltfmtu_X_7rxDaWM=s48-c-k-c0x00ffffff-no-rj'),
(20, 1, 2, 'Baru! Wardah White Secret kini menjadi Wardah Crystal Secret: Pliss jawab kak Wardah white secret itu boleh dipakai usia berapa ka?😫', 'https://www.youtube.com/watch?v=z-2FAiG3R_A', '2022-01-15 23:34:36', '@rohmawatikhasanah4795', 'https://yt3.ggpht.com/ytc/AIdro_l-WPruEngifbfolAJ9ooMYouWRIljSLSUdcbFXhpBKLR2w067aQRcH7LDc0zzrTdX9yg=s48-c-k-c0x00ffffff-no-rj'),
(21, 1, 3, '5 Q\'s for Wardah Inam, CEO of Overjet ·, a Boston-based company that offers an AI-powered dental imaging analysis platform. · What does...', 'https://datainnovation.org/2025/01/5-qs-for-wardah-inam-ceo-of-overjet/', '0000-00-00 00:00:00', 'Center for Data Innovation', NULL),
(22, 1, 3, 'Press release - HTF Market Intelligence Consulting Private Limited - Halal Sunscreen Market Growth Potential is Booming Now: Wardah,...', 'https://www.openpr.com/news/3961746/halal-sunscreen-market-growth-potential-is-booming-now-wardah', '0000-00-00 00:00:00', 'openPR.com', NULL),
(23, 1, 3, 'Our goal was to become the first objective standard for dentistry, by using AI to detect and quantify oral pathologies with more precision than...', 'https://pulse2.com/overjet-profile-wardah-inam-interview/', '0000-00-00 00:00:00', 'Pulse 2.0', NULL),
(24, 1, 3, 'Wardah\'s presence at Open Iftar London 2025 is proof that goodness knows no boundaries. From Indonesia to various parts of the world, Wardah...', 'https://www.prnewswire.co.uk/news-releases/kahf--wardah-support-open-iftar-london-2025-strengthening-global-brotherhood-302407307.html', '0000-00-00 00:00:00', 'PR Newswire UK', NULL),
(25, 1, 3, 'Figure 1 shows the sales trends of Wardah skincare products from 2020 to 2024, categorized into moisturizers, eye creams, face masks, and sunblock. The graph...', 'https://www.researchgate.net/figure/The-sales-of-Wardah-skincare-products-in-2020-2024-Source-Data-processed-from-Top-Brand_fig1_385926263', '0000-00-00 00:00:00', 'ResearchGate', NULL),
(26, 1, 3, 'In conversation with MARKETING-INTERACTIVE, ParagonCorp said that the campaign celebrates women who go beyond expectations, particularly during...', 'https://www.marketing-interactive.com/wardah-s-campaign-with-paragoncorp-inspires-women-during-ramadan', '0000-00-00 00:00:00', 'Marketing-Interactive', NULL),
(27, 1, 3, 'Indonesia\'s Wardah surges past global giants like Vaseline, Dove, and Nivea to become Southeast Asia\'s top beauty brand in 2024.', 'https://www.campaignasia.com/article/top-10-beauty-brands-in-southeast-asia/498066', '0000-00-00 00:00:00', 'Campaign Asia', NULL),
(28, 1, 3, 'Wardah Inam is disrupting the dental industry. She is the cofounder and CEO of Overjet, a Boston-based startup that uses FDA-cleared artificial intelligence to...', 'https://www.bostonglobe.com/tech-power-players/year/2023/person/wardah-inam-overjet/', '0000-00-00 00:00:00', 'The Boston Globe', NULL),
(29, 1, 3, 'Wardah introduced its newest technology, namely Wardah Color Intelligence which is integrated with Beauty AI Personal Color.', 'https://voi.id/en/technology/460264', '0000-00-00 00:00:00', 'VOI.ID', NULL),
(30, 1, 3, 'Living in a beautiful country like the UAE, where the spirit of Ramadan comes alive through stunning decorations, glowing lanterns and vibrant...', 'https://www.gulftoday.ae/culture/2025/03/02/radiance-of-ramadan-wardah-asad-reflects-on-art-and-the-holy-month', '0000-00-00 00:00:00', 'Gulf Today', NULL),
(31, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Good one 🎉', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-19 02:50:59', '@bindukashyap8749', 'https://yt3.ggpht.com/ytc/AIdro_mbz02ziXOCi5KaxhfVJBJaGpDsbI6ttxlF9VBV_purXMo=s48-c-k-c0x00ffffff-no-rj'),
(32, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: What about climacool?', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-17 08:55:41', '@bizibee1234', 'https://yt3.ggpht.com/R-glMqKflU-y246ghr3FNlXqSf6qWEWe0B4UZAjbEwoV-XlZOURpPZZu5889-PK7mFAJwM4HYw=s48-c-k-c0x00ffffff-no-rj'),
(33, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Did people forget about addias superstar?', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-14 21:44:31', '@aajjajaajajajajja-k6e', 'https://yt3.ggpht.com/ytc/AIdro_lVwICIdXFa1ZqPnlJnTv4SFfuRU1A_AODteTbyCBrRW5xHRe5Uim_mgvN8Z2GT4g_3fA=s48-c-k-c0x00ffffff-no-rj'),
(34, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Wow nice', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-14 11:04:03', '@Miracleshoes-t4x', 'https://yt3.ggpht.com/ytc/AIdro_m5evfCF_YxC_lDCZai6PdDPi8RLB_PVhrL3a1ARTLFBM2x9-KClsWFWW2FfUzwIrVBkQ=s48-c-k-c0x00ffffff-no-rj'),
(35, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: samba is so boring and ugly. I don‘t get the hype', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-12 04:24:27', '@mrqs83', 'https://yt3.ggpht.com/ytc/AIdro_nKWIczk1o26r8lgnkq_sGpeJkAaCThWoUQQHXqTGA=s48-c-k-c0x00ffffff-no-rj'),
(36, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: I have the white sambasa and love them. No issues with them.', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-12 03:56:30', '@moni1952', 'https://yt3.ggpht.com/ytc/AIdro_lks7HXNRgUTB2ngin3fc_yFQ82-k23iW2EPwaGgkY=s48-c-k-c0x00ffffff-no-rj'),
(37, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Definitely never been a Stan smith, samba fan. Not following the trend and hype..', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-09 18:57:10', '@priscillacarrillo4259', 'https://yt3.ggpht.com/ytc/AIdro_kZwIKmrpqZbBDzdKd3vQzjsMgnvHM3102MQxdoNf_P9vA=s48-c-k-c0x00ffffff-no-rj'),
(38, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Man the samba is the most uncomfortable shoe on the planet', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-04 10:27:04', '@BenTaylor-hq6cg', 'https://yt3.ggpht.com/ytc/AIdro_nYQvAmUyrYtkF2soc7ppz6IxaER9_xGSrVZLHiG4eUGMeY1Tl-U5nqn34h_UtOew4GdA=s48-c-k-c0x00ffffff-no-rj'),
(39, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: Stan Smiths are so trash I don’t get the hype', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-03 15:01:38', '@About_a_Bag', 'https://yt3.ggpht.com/4ayCCdtDzuz2iq1OpMsAsXsU1cj3354O1NKns9nIScIHJj9l6HZd10ut7F6xSgvnHDGELvi2Ag=s48-c-k-c0x00ffffff-no-rj'),
(40, 2, 2, 'Top 5 MUST HAVE Adidas Sneakers 🔥: The AE1&#39;s are just a Yeezy rip off. Stole his designs.', 'https://www.youtube.com/watch?v=adbZsDLff3I', '2025-04-02 15:10:53', '@Jimmy-es8bc', 'https://yt3.ggpht.com/ytc/AIdro_mqS2ojm7zY776HBwNXBXtdd3l_AO6DonPXU7uj6WjhzRZh=s48-c-k-c0x00ffffff-no-rj'),
(41, 2, 3, '\'When you\'re doing something that you love … it inspires me every single day,\' says WNBA legend turned president of Adidas Women\'s...', 'https://andscape.com/features/for-candace-parker-year-1-as-an-adidas-exec-has-meant-aligning-passion-purpose/', '0000-00-00 00:00:00', 'Andscape', NULL),
(42, 2, 3, 'UK sneaker chain Size? has released two new retailer-exclusive adidas Handball Spezial colorways. Tap to read our full breakdown.', 'https://sneakernews.com/2025/04/19/adidas-handball-spezial-mesh-pack-size-exclusive/', '0000-00-00 00:00:00', 'Sneaker News', NULL),
(43, 2, 3, 'Buyers are saving as much as 72% right now on this canceled collab between Kanye West and Adidas.', 'https://athlonsports.com/other-sports/adidas-yeezy-qntm-basketball-shoes-shoebacca-sale', '0000-00-00 00:00:00', 'Athlon Sports', NULL),
(44, 2, 3, 'The semifinals are set at the 2025 Generation adidas Cup. Two European sides and two MLS academies remain alive in the U16 age group,...', 'https://www.mlssoccer.com/news/generation-adidas-cup-real-salt-lake-u16s-book-semifinal-date-with-krc-genk', '0000-00-00 00:00:00', 'MLSsoccer.com', NULL),
(45, 2, 3, 'Our in-depth review of the Adidas Boston 13, a versatile trainer that can be used from anything from daily training to uptempo paces.', 'https://believeintherun.com/shoe-reviews/adidas-adizero-boston-13-review/', '0000-00-00 00:00:00', 'Believe in the Run', NULL),
(46, 2, 3, 'After receiving his inaugural signature boot back in 2023, Son Heung-Min now receives his second as adidas sort him out with the F50...', 'https://www.soccerbible.com/performance/football-boots/2025/04/adidas-launch-second-signature-f50-for-son-heung-min/', '0000-00-00 00:00:00', 'SoccerBible', NULL),
(47, 2, 3, 'Adidas Ultraboost 1.0 Fortnite Shoes are just $135 right now. Shoppers say they\'re “lightweight, durable, and great for all-day comfort.”', 'https://www.mensjournal.com/shopping/adidas-ultraboost-1-fortnite-shoes-sale', '0000-00-00 00:00:00', 'Men\'s Journal', NULL),
(48, 2, 3, 'Built for the streets! Kader\'s signature adidas Skateboarding pants are stylish and skate-ready in a new black colorway.', 'https://www.skateboarding.com/trending-news/kader-sylla-and-adidas-skateboarding-signature-pants', '0000-00-00 00:00:00', 'TransWorld SKATEboarding', NULL),
(49, 2, 3, 'The Adidas Kaptir 3.0 Running Shoes are on sale at Amazon for $46, and shoppers said \"it\'s like walking on a cloud.\"', 'https://www.thestreet.com/deals/adidas-kaptir-3-running-shoes-amazon-sale', '0000-00-00 00:00:00', 'TheStreet', NULL),
(50, 2, 3, 'Adidas teams up with West NYC to ring in the 85th anniversary of its sister store Tip Top Shoes with a limited-edition sneaker capsule.', 'https://footwearnews.com/shoes/sneaker-news/adidas-west-nyc-sneakers-tip-top-shoes-anniversary-1234800883/', '0000-00-00 00:00:00', 'Footwear News', NULL),
(51, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: I thought it would be 300 at most, but 900 is just crazy', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-20 00:42:48', '@KOKOBC', 'https://yt3.ggpht.com/Wv4v0TZBukTi3ceoI32y5NrCvSvUuoju7dw2-VzA3zeKKPQUwrHw529UWHk6KYJ_EWBBO11drw=s48-c-k-c0x00ffffff-no-rj'),
(52, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: Made in China, right 😂?', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-20 00:11:14', '@cueva_de_las_estrellas', 'https://yt3.ggpht.com/ibXky58_Lu3p0F-b2q07n1QpuDt10Z_HnSTHcpxBuqI5htoD0r01BYcD472QDfeToD2D4NPTAA=s48-c-k-c0x00ffffff-no-rj'),
(53, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: lol', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 23:12:50', '@magichead79', 'https://yt3.ggpht.com/ytc/AIdro_lNSqadg5CknxRW2DCBLjgpoe02P3wQvmWWlJ5BSjFHByQ=s48-c-k-c0x00ffffff-no-rj'),
(54, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: It looks incredible 👍', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 21:39:31', '@Maxmp5', 'https://yt3.ggpht.com/ytc/AIdro_mNEAv5MPjwUYT_oMN-I_oKxZXRDcwTzQ5m2dLC8BLZIN_r2XL_arB8rM0NkGGWBLQJXQ=s48-c-k-c0x00ffffff-no-rj'),
(55, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: Fancy marketing, the way to drive business.', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 20:40:00', '@godjii', 'https://yt3.ggpht.com/ytc/AIdro_lhdbT9Be2kjLS5WbO_sAZR_z7TXnpsTSUnXbA19dBNSOk=s48-c-k-c0x00ffffff-no-rj'),
(56, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: Remember the Nike Adapt BB and how now all that tech is useless?', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 20:27:07', '@snoozelp1', 'https://yt3.ggpht.com/ytc/AIdro_lx9es-vGamLTgAa5wBzM2eUExGOoRzj_1mVloxyno=s48-c-k-c0x00ffffff-no-rj'),
(57, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: Nice..is it made in China?', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 19:54:18', '@lloydlausa5314', 'https://yt3.ggpht.com/ytc/AIdro_lKN9LXEBJHs_wKR_kxstw67Xzw1P3LNl8LJmCB-QYig7I=s48-c-k-c0x00ffffff-no-rj'),
(58, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: Heat and compression are nice, but that gimmicky spring sole and narrow toe box need to go. Make it with a wide foot-shaped toe box and zero drop sole and I might buy a pair.', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 18:09:24', '@Caliberx427', 'https://yt3.ggpht.com/ytc/AIdro_kEzdOLGk74awFGNz_LmcIDYc4st_qA75sn_BqCqII=s48-c-k-c0x00ffffff-no-rj'),
(59, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: Why do we even need feet', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 18:01:31', '@vtcanada2000', 'https://yt3.ggpht.com/gbguWqf6hK27Bp23QTdf61d4jhYgNlmtq_HANHRU0QV39e-1IOvLzLfkyw2_K6ZcTnidyZLWmw=s48-c-k-c0x00ffffff-no-rj'),
(60, 3, 2, 'Behind the Hyperboot: A Nike x Hyperice Innovation | Nike: what does that woman have in her hands?? looks scary', 'https://www.youtube.com/watch?v=ttCmbb-jb_U', '2025-04-19 16:32:25', '@davidg8104', 'https://yt3.ggpht.com/ytc/AIdro_l89QYz66U8yeYQuuLntdCfvATOvSuqLj7Ec6zIRlGTx1Q=s48-c-k-c0x00ffffff-no-rj'),
(61, 3, 3, 'The Nike GT Cut 3 Turbo has surfaced in a \"South Beach\" colorway. Tap to read our full breakdown, including official images.', 'https://sneakernews.com/2025/04/17/nike-gt-cut-3-turbo-multi-color-hv9918-900/', '0000-00-00 00:00:00', 'Sneaker News', NULL),
(62, 3, 3, 'Proving that outdoor gear doesn\'t have to always look utilitarian, Nike\'s ACG label has been infusing its functional jackets and shoes with...', 'https://hiconsumption.com/style/best-nike-acg-gear-april-2025/', '0000-00-00 00:00:00', 'HiConsumption', NULL),
(63, 3, 3, 'The Nike Air Max 270 sneaker is on sale in select sizes, but only for a limited time', 'https://www.al.com/shopping/2025/04/the-nike-air-max-270-sneaker-is-on-sale-in-select-sizes-but-only-for-a-limited-time.html', '0000-00-00 00:00:00', 'AL.com', NULL),
(64, 3, 3, 'Nike Air Max 90 Receives a \"White/Light Crimson\" Iteration', 'https://hypebeast.com/2025/4/nike-air-max-90-white-light-crimson-dm0029-118-release-info', '0000-00-00 00:00:00', 'Hypebeast', NULL),
(65, 3, 3, 'Nike Is Selling Highly Rated Air Max Shoes for as Much as 39% Off, and Buyers Say They\'re \'Absolutely Perfect\'', 'https://athlonsports.com/other-sports/nike-air-max-90-mens-shoes-nike-sale', '0000-00-00 00:00:00', 'Athlon Sports', NULL),
(66, 3, 3, 'Olympian-Tested Nike-Hyperice Hyperboot Launches At Retail', 'https://www.forbes.com/sites/timnewcomb/2025/04/17/olympian-tested-nike-hyperice-hyperboot-launches-at-retail/', '0000-00-00 00:00:00', 'Forbes', NULL),
(67, 3, 3, 'The $900 Nike Hyperboot Is A Game Changer For Warm-Up And Recovery', 'https://sneakernews.com/2025/04/17/nike-hyperboot-release-date/', '0000-00-00 00:00:00', 'Sneaker News', NULL),
(68, 3, 3, 'I Soothed My Achy Achilles With These Futuristic High-Top Sneakers', 'https://www.runnersworld.com/gear/a64504500/nike-x-hyperice-hyperboot-review/', '0000-00-00 00:00:00', 'Runner\'s World', NULL),
(69, 3, 3, 'There is no doubt about it. Runners love the latest iteration of Nike\'s Vomero running shoes. Nike says, \"Maximum cushioning in the Vomero...', 'https://athlonsports.com/other-sports/nike-vomero-18-road-running-shoes-nike-sale', '0000-00-00 00:00:00', 'Athlon Sports', NULL),
(70, 3, 3, 'Revolve has your favorite Nike Dunk Low sneaker styles marked down as low as $63. Shop this big sale and grab these cheap prices before they...', 'https://www.nj.com/shopping-deals/2025/04/grab-nike-dunk-low-sneakers-for-super-cheap-with-deals-as-low-as-63-at-revolve.html', '0000-00-00 00:00:00', 'NJ.com', NULL),
(71, 4, 1, '@TheNationNews Pls can anyone spare me any amount to buy food today at my hostel please you won\'t know sorrow. Pls I\'m starving and in pain the pain I\'m going through right now is unbearable. no food stuff again I just want to buy indomie and cook pls I beg you. 0254539731 GTB bank', 'https://twitter.com/i/web/status/1913862913464414699', '2025-04-20 00:50:51', 'Elizabet10911', 'https://pbs.twimg.com/profile_images/1906007366035767296/googCBhQ_normal.jpg'),
(72, 4, 1, 'RT @racuncune: Resep indomie yg bisa km coba dirumah🤤 https://t.co/r8XmOOxaGa', 'https://twitter.com/i/web/status/1913862911313014984', '2025-04-20 00:50:50', 'wulWul2201', 'https://pbs.twimg.com/profile_images/1451510603357442055/PlcZejPX_normal.jpg'),
(73, 4, 1, '@Mrdick_1 Pls can anyone spare me any amount to buy food today at my hostel please you won\'t know sorrow. Pls I\'m starving and in pain the pain I\'m going through right now is unbearable. no food stuff again I just want to buy indomie and cook pls I beg you. 0254539731 GTB bank', 'https://twitter.com/i/web/status/1913862907969884469', '2025-04-20 00:50:49', 'Elizabet10911', 'https://pbs.twimg.com/profile_images/1906007366035767296/googCBhQ_normal.jpg'),
(74, 4, 1, 'RT @racuncune: Resep indomie yg bisa km coba dirumah🤤 https://t.co/r8XmOOxaGa', 'https://twitter.com/i/web/status/1913862866987549004', '2025-04-20 00:50:39', 'MasWibu03', 'https://pbs.twimg.com/profile_images/1902391564384804864/5ixwJ0zH_normal.jpg'),
(75, 4, 1, 'RT @racuncune: Resep indomie yg bisa km coba dirumah🤤 https://t.co/r8XmOOxaGa', 'https://twitter.com/i/web/status/1913862843688272258', '2025-04-20 00:50:34', 'khjz0106', 'https://pbs.twimg.com/profile_images/1900456624126676992/d2om9EPo_normal.jpg'),
(76, 4, 1, '@jeffphilips1 Pls can anyone spare me any amount to buy food today at my hostel please you won\'t know sorrow. Pls I\'m starving and in pain the pain I\'m going through right now is unbearable. no food stuff again I just want to buy indomie and cook pls I beg you. 0254539731 GTB bank', 'https://twitter.com/i/web/status/1913862832166162449', '2025-04-20 00:50:31', 'Elizabet10911', 'https://pbs.twimg.com/profile_images/1906007366035767296/googCBhQ_normal.jpg'),
(77, 4, 1, '@wealthyinka Pls can anyone spare me any amount to buy food today at my hostel please you won\'t know sorrow. Pls I\'m starving and in pain the pain I\'m going through right now is unbearable. no food stuff again I just want to buy indomie and cook pls I beg you. 0254539731 GTB bank', 'https://twitter.com/i/web/status/1913862820766138414', '2025-04-20 00:50:28', 'Elizabet10911', 'https://pbs.twimg.com/profile_images/1906007366035767296/googCBhQ_normal.jpg'),
(78, 4, 1, '@Dynast37350780 @ARISEtv Pls can anyone spare me any amount to buy food today at my hostel please you won\'t know sorrow. Pls I\'m starving and in pain the pain I\'m going through right now is unbearable. no food stuff again I just want to buy indomie and cook pls I beg you. 0254539731 GTB bank', 'https://twitter.com/i/web/status/1913862753074184669', '2025-04-20 00:50:12', 'Elizabet10911', 'https://pbs.twimg.com/profile_images/1906007366035767296/googCBhQ_normal.jpg'),
(79, 4, 1, 'RT @racuncune: Resep indomie yg bisa km coba dirumah🤤 https://t.co/r8XmOOxaGa', 'https://twitter.com/i/web/status/1913862746770457044', '2025-04-20 00:50:11', 'jenooooleey', 'https://pbs.twimg.com/profile_images/1913813869845454849/w5Y14F6A_normal.jpg'),
(80, 4, 1, '@ArinzeAnamene @ARISEtv Pls can anyone spare me any amount to buy food today at my hostel please you won\'t know sorrow. Pls I\'m starving and in pain the pain I\'m going through right now is unbearable. no food stuff again I just want to buy indomie and cook pls I beg you. 0254539731 GTB bank', 'https://twitter.com/i/web/status/1913862734958968914', '2025-04-20 00:50:08', 'Elizabet10911', 'https://pbs.twimg.com/profile_images/1906007366035767296/googCBhQ_normal.jpg'),
(81, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: Aku lihat video ini sambil makan indomie', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-11 21:35:29', '@shahlinzainal', 'https://yt3.ggpht.com/ytc/AIdro_nz0WQ2urjkwjkAfqK_EdLBYiMnKV9tTCAehms64-BY7J4wgAZK-pM-tV9QNNg395wpAQ=s48-c-k-c0x00ffffff-no-rj'),
(82, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: Jadi cuman modal indomie kita bisa 🤨 di afrika', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-19 07:58:30', '@saudarasiregar5510', 'https://yt3.ggpht.com/NSav9BkBRZmEZhBA-aA-wWx9dWUF2Q1pVp8-wng59s-wkP8WeH6QumkyVbOMpOPy4CilOV7wtPI=s48-c-k-c0x00ffffff-no-rj'),
(83, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: Dulu Amerika minta bantuan untuk Indonesia biar kuat sekarang malah Indomie yang populer di situ apakah Indonesia menjadi kaya raya dengan Amerika membeli Indomie terus-menerus', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-17 21:50:44', '@MiraLinda-ji4hg', 'https://yt3.ggpht.com/9FGmukkpLSTHzUqKYvNH6esLn_XzWAsSx-s4iU2fqzT0PEFti4blpPLwz2mgOuAAGnaxMLnh=s48-c-k-c0x00ffffff-no-rj'),
(84, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: I itu bukan gara gara Indonesia', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-17 18:38:50', '@azzam-ox4hw', 'https://yt3.ggpht.com/ytc/AIdro_lImTm6IlMTJaYhHDnM7oicZZ166Z81MNcmaOUeq6VI87qejGFPJ63x3dMS0eFRNb-3qw=s48-c-k-c0x00ffffff-no-rj'),
(85, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: Tiber', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-17 04:18:13', '@nfarieshaa', 'https://yt3.ggpht.com/3yYpLCZJHhJ7YNe_3DXKCxWuqLOjpxVYexY_Rmn1F0UAWIWWqdUnmQIrn-TRMB0Q90ycAFMHbQ=s48-c-k-c0x00ffffff-no-rj'),
(86, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: Aku aja lagi makan', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-16 03:12:18', '@RadithyaBarausjaa', 'https://yt3.ggpht.com/IzKBup37nrUppjilC4amwr-c4tM0JjB_smwb1IgsmEp7g_nvL4L5wrNPJC3ClXt3anVUIqmt=s48-c-k-c0x00ffffff-no-rj'),
(87, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: 🤤🤤🤤🤤🤤🤤🤤🤤🤤🤤', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-14 23:13:31', '@rizalalifi-xp6mz', 'https://yt3.ggpht.com/ytc/AIdro_lR5lJKHBKma-MFNoEi_D8kgDi-B-WvpslIDTgGkzP_wkHD4scTan_E6xxFUNBzY--ofA=s48-c-k-c0x00ffffff-no-rj'),
(88, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: Thanks❤❤❤❤❤❤', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-14 21:52:29', '@Ayi-l9i', 'https://yt3.ggpht.com/ytc/AIdro_n0P3r2dt_xOW7IMpld2RrxGBWw0u14CCrewTD_k6rGgh-rAJJjEjQc9tcAQhDqX28vZA=s48-c-k-c0x00ffffff-no-rj'),
(89, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: 5000ribu bisa makan makanan sultan', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-14 06:53:40', '@KamilKamil-he9tx', 'https://yt3.ggpht.com/ytc/AIdro_lry5t2S9CBkuXn7Kq1b9WOi6QeOlVNz7kq18pNWnkNZ_GIVopzjXPkqp_Y2rf2p4WTSA=s48-c-k-c0x00ffffff-no-rj'),
(90, 4, 2, 'PUNYA INDOMIE JADI SULTAN DI AFRIKA: 9999', 'https://www.youtube.com/watch?v=3B8HuHoTYNE', '2025-04-14 06:49:10', '@FrediAde', 'https://yt3.ggpht.com/ytc/AIdro_n1YRi8i8TpTnKtMIARSi9xPLn2rKU-ONxy_O_TrQ3cSvg7zMr2VhNJEvOs1oIoKW7QLA=s48-c-k-c0x00ffffff-no-rj'),
(91, 4, 3, 'Share this article ... K-Pop group NewJeans have officially been tapped as the global brand ambassadors for the iconic noodle brand Indomie.', 'https://hypebeast.com/2024/11/indomie-newjeans-global-brand-ambassadors-announcement', '0000-00-00 00:00:00', 'Hypebeast', NULL),
(92, 4, 3, 'The search for Nigeria\'s most courageous and inspiring children has officially begun as Dufil Prima Foods Ltd., makers of Indomie Instant Noodles,...', 'https://www.msn.com/en-xl/africa/nigeria/indomie-launches-hunt-for-brave-nigerian-children-in-17th-heroes-awards/ar-AA1D3cqU', '0000-00-00 00:00:00', 'MSN', NULL),
(93, 4, 3, 'Labake Fasogbon. In furtherance of its commitment to youth and societal growth, indigenous noodles brand, Indomie has stepped up efforts...', 'https://www.thisdaylive.com/index.php/2025/04/19/indomie-sustains-initiative-empowering-brave-teens/', '0000-00-00 00:00:00', 'THISDAYLIVE', NULL),
(94, 4, 3, 'Indomie is taking things to the next level by teaming up with K-Pop sensation, NewJeans for it\'s vibrant global campaign, “Oh My Good! It\'s Indomie.”', 'https://hypebae.com/2024/11/indomie-newjeans-global-brand-ambassador', '0000-00-00 00:00:00', 'Hypebae', NULL),
(95, 4, 3, 'Ex-Navy sailor duo opens stall with fried rice, Indomie goreng & crab omelette ... The owners of the newly-opened WOK N ROLL at 378 Alexandra Road...', 'https://sg.style.yahoo.com/ex-navy-sailor-duo-opens-020053627.html', '0000-00-00 00:00:00', 'Yahoo Life Singapore', NULL),
(96, 4, 3, 'It\'s Indomie.” NewJeans, known for their vibrant musical style and massive following, has been chosen as Indomie\'s global brand ambassador to...', 'https://www.trendhunter.com/trends/indomie', '0000-00-00 00:00:00', 'Trend Hunter', NULL),
(97, 4, 3, 'The search for Nigeria\'s most inspiring young heroes has officially begun. Recently, Dufil Prima Foods Ltd., maker of Indomie Instant...', 'https://businessday.ng/brands-advertising/article/spotlight-on-bravery-as-firm-kicks-off-next-indomie-heroes-awards/', '0000-00-00 00:00:00', 'Businessday NG', NULL),
(98, 4, 3, 'Indomie Leverages AI technology to celebrate Mother\'s Day in an Immersive Digital Experience ... Indomie noodles has launched its groundbreaking...', 'https://www.vanguardngr.com/2025/03/indomie-leverages-ai-technology-to-celebrate-mothers-day-in-an-immersive-digital-experience/', '0000-00-00 00:00:00', 'Vanguard News', NULL),
(99, 4, 3, 'Indomie Instant Noodles redefined Mother\'s Day with a celebration that seamlessly blended love, technology, and unforgettable experiences.', 'https://www.bellanaija.com/2025/04/indomie-x-mothers-day-2025/', '0000-00-00 00:00:00', 'BellaNaija', NULL),
(100, 4, 3, 'While the page continues to advertise Indomie products to Nigerians, it has reviews from people who are not Nigerians.', 'https://fij.ng/article/alert-fake-indomie-page-scamming-nigerians-on-facebook/', '0000-00-00 00:00:00', 'FIJ NG', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `media_sources`
--

CREATE TABLE `media_sources` (
  `id` int(11) NOT NULL,
  `source_name` varchar(100) DEFAULT NULL,
  `source_type` enum('news','social') DEFAULT NULL,
  `source_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `media_sources`
--

INSERT INTO `media_sources` (`id`, `source_name`, `source_type`, `source_url`, `is_active`) VALUES
(1, 'Twitter', 'social', 'https://twitter.com', 1),
(2, 'YouTube', 'social', 'https://youtube.com', 1),
(3, 'Google News', 'news', 'https://news.google.com', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_keyword` int(11) DEFAULT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `projects`
--

INSERT INTO `projects` (`id`, `id_user`, `id_keyword`, `project_name`, `is_active`, `createdAt`, `deletedAt`) VALUES
(2, 2, 1, 'project wardah', 1, '2025-04-20 07:22:28', NULL),
(3, 2, 2, 'project adidas', 1, '2025-04-20 07:44:04', NULL),
(4, 2, 3, 'project nike', 1, '2025-04-20 07:48:34', NULL),
(5, 2, 4, 'project indomie', 1, '2025-04-20 07:50:17', NULL),
(6, 2, 4, 'project indomiee', 1, '2025-04-20 07:55:02', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `reports`
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

-- --------------------------------------------------------

--
-- Struktur dari tabel `sentiment_analysis`
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
-- Dumping data untuk tabel `sentiment_analysis`
--

INSERT INTO `sentiment_analysis` (`id`, `id_mentions`, `sentiment_score`, `sentiment_category`, `language`, `analyzedAt`) VALUES
(1, 1, '2.00', 'positive', 'id', '2025-04-20 07:51:14'),
(2, 2, '-1.00', 'negative', 'en', '2025-04-20 07:51:14'),
(3, 3, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(4, 4, NULL, NULL, 'other', '2025-04-20 07:51:14'),
(5, 5, NULL, NULL, 'other', '2025-04-20 07:51:14'),
(6, 6, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(7, 7, NULL, NULL, 'other', '2025-04-20 07:51:14'),
(8, 8, NULL, NULL, 'other', '2025-04-20 07:51:14'),
(9, 9, '2.00', 'positive', 'en', '2025-04-20 07:51:14'),
(10, 10, '-1.00', 'negative', 'en', '2025-04-20 07:51:14'),
(11, 11, '-3.00', 'negative', 'id', '2025-04-20 07:51:14'),
(12, 12, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(13, 13, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(14, 14, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(15, 15, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(16, 16, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(17, 17, '2.00', 'positive', 'id', '2025-04-20 07:51:14'),
(18, 18, '2.00', 'positive', 'id', '2025-04-20 07:51:14'),
(19, 19, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(20, 20, '0.00', 'neutral', 'id', '2025-04-20 07:51:14'),
(21, 21, '0.00', 'neutral', 'en', '2025-04-20 07:51:14'),
(22, 22, '1.00', 'positive', 'en', '2025-04-20 07:51:14'),
(23, 23, '0.00', 'neutral', 'en', '2025-04-20 07:51:14'),
(24, 24, '2.00', 'positive', 'en', '2025-04-20 07:51:14'),
(25, 25, '0.00', 'neutral', 'en', '2025-04-20 07:51:14'),
(26, 26, '3.00', 'positive', 'en', '2025-04-20 07:51:14'),
(27, 27, '7.00', 'positive', 'en', '2025-04-20 07:51:15'),
(28, 28, '-2.00', 'negative', 'en', '2025-04-20 07:51:15'),
(29, 29, '3.00', 'positive', 'en', '2025-04-20 07:51:15'),
(30, 30, '11.00', 'positive', 'en', '2025-04-20 07:51:15'),
(31, 31, '5.00', 'positive', 'en', '2025-04-20 07:51:15'),
(32, 32, '2.00', 'positive', 'en', '2025-04-20 07:51:15'),
(33, 33, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(34, 34, '9.00', 'positive', 'en', '2025-04-20 07:51:15'),
(35, 35, '-1.00', 'negative', 'en', '2025-04-20 07:51:15'),
(36, 36, '4.00', 'positive', 'en', '2025-04-20 07:51:15'),
(37, 37, '2.00', 'positive', 'en', '2025-04-20 07:51:15'),
(38, 38, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(39, 39, '2.00', 'positive', 'en', '2025-04-20 07:51:15'),
(40, 40, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(41, 41, '5.00', 'positive', 'en', '2025-04-20 07:51:15'),
(42, 42, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(43, 43, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(44, 44, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(45, 45, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(46, 46, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(47, 47, '3.00', 'positive', 'en', '2025-04-20 07:51:15'),
(48, 48, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(49, 49, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(50, 50, '2.00', 'positive', 'en', '2025-04-20 07:51:15'),
(51, 51, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(52, 52, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(53, 53, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(54, 54, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(55, 55, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(56, 56, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(57, 57, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(58, 58, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(59, 59, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(60, 60, '-1.00', 'negative', 'en', '2025-04-20 07:51:15'),
(61, 61, '-1.00', 'negative', 'en', '2025-04-20 07:51:15'),
(62, 62, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(63, 63, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(64, 64, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(65, 65, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(66, 66, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(67, 67, '0.00', 'neutral', 'en', '2025-04-20 07:51:15'),
(68, 68, '3.00', 'positive', 'en', '2025-04-20 07:51:15'),
(69, 69, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(70, 70, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(71, 71, '-5.00', 'negative', 'en', '2025-04-20 07:51:15'),
(72, 72, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(73, 73, '-5.00', 'negative', 'en', '2025-04-20 07:51:15'),
(74, 74, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(75, 75, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(76, 76, '-5.00', 'negative', 'en', '2025-04-20 07:51:15'),
(77, 77, '-5.00', 'negative', 'en', '2025-04-20 07:51:15'),
(78, 78, '-5.00', 'negative', 'en', '2025-04-20 07:51:15'),
(79, 79, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(80, 80, '-5.00', 'negative', 'en', '2025-04-20 07:51:15'),
(81, 81, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(82, 82, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(83, 83, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(84, 84, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(85, 85, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(86, 86, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(87, 87, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(88, 88, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(89, 89, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(90, 90, '0.00', 'neutral', 'id', '2025-04-20 07:51:15'),
(91, 91, '1.00', 'positive', 'en', '2025-04-20 07:51:15'),
(92, 92, '5.00', 'positive', 'en', '2025-04-20 07:51:15'),
(93, 93, '2.00', 'positive', 'en', '2025-04-20 07:51:15'),
(94, 94, '3.00', 'positive', 'en', '2025-04-20 07:51:15'),
(95, 95, '-2.00', 'negative', 'en', '2025-04-20 07:51:15'),
(96, 96, NULL, NULL, 'other', '2025-04-20 07:51:15'),
(97, 97, '5.00', 'positive', 'en', '2025-04-20 07:51:15'),
(98, 98, '4.00', 'positive', 'en', '2025-04-20 07:51:15'),
(99, 99, '5.00', 'positive', 'en', '2025-04-20 07:51:15'),
(100, 100, '0.00', 'neutral', 'en', '2025-04-20 07:51:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `email`, `password`) VALUES
(1, 'una', 'Nisaul Husna', 'nisaulHusnaaa@email.com', '$2b$10$aGsoSYLsT2RBlOX6gJ1lx.cR.Aij/8/9zb4uYhQtRS58iRFFbPY2K'),
(2, 'intan', 'Intan Febyola', 'intanFeb@email.com', '$2b$10$1lm20v2YbQJIRGJlyqzBEunRWSvrAz2x5Lts8BlTwsMGCrUP9ZRTu'),
(3, 'karenina', 'Karenina Malik', 'kareninaMalik@email.com', '$2b$10$c/pFdwcoDrdSMKW8u/2MO.cRWqycpUMIX6HsWApPnxc.gMHEAgtwC');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `email_settings`
--
ALTER TABLE `email_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `log_activities`
--
ALTER TABLE `log_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `media_mentions`
--
ALTER TABLE `media_mentions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_keyword` (`id_keyword`),
  ADD KEY `id_mediaSource` (`id_mediaSource`);

--
-- Indeks untuk tabel `media_sources`
--
ALTER TABLE `media_sources`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_keyword` (`id_keyword`);

--
-- Indeks untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_project` (`id_project`);

--
-- Indeks untuk tabel `sentiment_analysis`
--
ALTER TABLE `sentiment_analysis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mentions` (`id_mentions`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `email_settings`
--
ALTER TABLE `email_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `log_activities`
--
ALTER TABLE `log_activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `media_mentions`
--
ALTER TABLE `media_mentions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT untuk tabel `media_sources`
--
ALTER TABLE `media_sources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sentiment_analysis`
--
ALTER TABLE `sentiment_analysis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `log_activities`
--
ALTER TABLE `log_activities`
  ADD CONSTRAINT `log_activities_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `media_mentions`
--
ALTER TABLE `media_mentions`
  ADD CONSTRAINT `media_mentions_ibfk_1` FOREIGN KEY (`id_keyword`) REFERENCES `keywords` (`id`),
  ADD CONSTRAINT `media_mentions_ibfk_2` FOREIGN KEY (`id_mediaSource`) REFERENCES `media_sources` (`id`);

--
-- Ketidakleluasaan untuk tabel `projects`
--
ALTER TABLE `projects`
  ADD CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `projects_ibfk_2` FOREIGN KEY (`id_keyword`) REFERENCES `keywords` (`id`);

--
-- Ketidakleluasaan untuk tabel `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`id_project`) REFERENCES `projects` (`id`);

--
-- Ketidakleluasaan untuk tabel `sentiment_analysis`
--
ALTER TABLE `sentiment_analysis`
  ADD CONSTRAINT `sentiment_analysis_ibfk_1` FOREIGN KEY (`id_mentions`) REFERENCES `media_mentions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
