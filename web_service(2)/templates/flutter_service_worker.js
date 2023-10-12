'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "5869317ecdf1266d610b7a4f9c376a05",
".git/config": "8559abdca63d26f268983c9b8567a848",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "2c0b957bc1ee7ec1ab46b19120d30452",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "7971e74c2480dcefa2ff9792c7a9da3c",
".git/logs/refs/heads/master": "7971e74c2480dcefa2ff9792c7a9da3c",
".git/logs/refs/remotes/origin/master": "faa00a11975af0336cd8af3fba84ec31",
".git/objects/01/bcca7d1c23955f7aeda6a269b1b7f540802096": "635a6822e2a56f7f333d54c66b0234db",
".git/objects/0a/707e0743b36274129f731f6aaac683bdc492f2": "6965ac748d04b28da0e68d39725c3efe",
".git/objects/0a/e964cc696d86edbdde4d81cb9774584af0769c": "9d36b378b9102a6b150a7b4e1d79f0a9",
".git/objects/0b/bdb9dde41d27683986cf2e3884f0eb353247af": "7ad99d0b276d5ad3f43c766ac5ba322d",
".git/objects/0d/33afa37906496971caec4abeea71a0b6932c60": "25a988e997669b465dbc9b8b78383909",
".git/objects/0d/d8edd6fa8202d19906da73571d49699ed96bf7": "cdba7f740da090b8dae3a6725f55e09c",
".git/objects/0e/1373a5dcd93c2497d0d82975bc339b4f580f19": "8b95d7de59e01fa0ca6275b9e6e6c938",
".git/objects/10/68817f5a67ec08dfa8c9b7dfb7939d98153865": "21942346004092890476b0c47c963721",
".git/objects/17/43b661f13dbb74f08664de2d4bc4c02935466c": "ff06194f2be4836a23d1de4a104eae57",
".git/objects/19/340c8ec56d8c0087e10b304609cff7c508712b": "00f94072814ca497f6a2e1d404087d1a",
".git/objects/1a/1f204b0710cc50f7695ff0246c5c91ebeb989e": "5bbb946b1469000f58e39445ea66e923",
".git/objects/1a/5ee77f24baec6db090698b3dd42ae679bc1f83": "1a68cb42db2a911de15d2226a832f140",
".git/objects/1a/c0ac9f53c5ee9c6046609735f275b23b09b644": "0cf915dbbe52f860515f39516a1cc48a",
".git/objects/1b/845a659cd4c1d8d9688bd011e5a7d2ba3c4d2b": "f3fd18b27640a96edf8d12647977f0f9",
".git/objects/1e/d949cb8af101477baac339ac88006aa81574a0": "9a191651b5adffaebe69b68aba04596d",
".git/objects/1e/f5248e76ad6b149c1365ae7fbb68da9235b425": "8e1d2fa5b4e45a9e6754ed6d6c7467d6",
".git/objects/1f/2dd4a4dfaa34c5ad50343ec5666a357bc48db9": "12840e36a66fc5c5c86a8e951b576751",
".git/objects/1f/6803dafa4e901d410d2947364836a4cd569afa": "af84d7ee08998d3bca9aa888d7e84fcb",
".git/objects/1f/b34f32494b2c91bf1aa0e549cd3d1222b502b8": "029905f0a44303a99453b4f851c67c0e",
".git/objects/20/bf87ce5b83c55ab122d12431e6834bf7901eba": "41adde3ddeea40934f5475b2308f4040",
".git/objects/24/e7df832b060830b5c36c300181b530217d2fa6": "b5d2369b1466740d7eb460dde14344a4",
".git/objects/29/a06fff8211736361204af9d7e3178cecd70df2": "75fd668b7c8e5cc5bfb06e43e904d792",
".git/objects/2b/76f9d31ee68b2a4beab88cda92da81640cbf23": "2381dc3ce789918c12a6389c558f1bea",
".git/objects/30/3ea1f33e3c3b22eef594cc2200fd46073e92de": "4b188440460362da0a480a2c71952c5f",
".git/objects/30/6dac5ed8d40c1a67b51105b2c459a386061bc3": "0a17491a92c8dee602194b7eabdb73a1",
".git/objects/31/a7963e289e9e1d4233f12cbf612c2d970136ff": "d9613f2cb5a1f359da41f2495b4e5397",
".git/objects/32/533d01d64c2a6d3fed28af9b49de7185321b4e": "282769716ed8767f47bb4505c1e32f55",
".git/objects/35/271e0fa0e8c2b08ff58b346e1763447efb8c65": "fe08e19626d048bc38096009de24d4a2",
".git/objects/35/91af41948adc8001f3586d76b91181311953fc": "c91d33b29071dcff3b2b3385383761cb",
".git/objects/36/21935c547dfa6f6e21319da9ac9997b8e0dd9e": "373e2debaba7307c5a8d654e84850f54",
".git/objects/36/3b8dd2284764179fd31518ed6260c3a210c76d": "91ca8c4aa2082e2843b92be1a47bf595",
".git/objects/38/28eb80feac350f2a7f635c53d66b6c073b5e32": "5077af171dbf396c98d52f583bbe38f8",
".git/objects/3a/029a05997d824d9331c9d6ba22637a7888eb4b": "788eb300da730d0979a72c02851e72f8",
".git/objects/3f/2c9fb5ef3b1d749abbbbac55c4c8f0b8a5ca61": "3324b2bf0d6d6918413c30b89a1c33fb",
".git/objects/40/c7704b092bce1604449c44ed4081f9801f80d2": "8c64855e1e88e8a3317cda625d90f66c",
".git/objects/41/5c059c8094b888b0159fdedfd4e3cb08a8028e": "86914685ccd40e82a7fe5b70459fb9f7",
".git/objects/42/9801f839f687dc1ce8ac689e657e7ddc731311": "1d5fd63e7d7e57dc342daf503e8ecca8",
".git/objects/43/6fc0e4c7c101983a0fb272fe003b52833f9fff": "a63a8fdf43be0a79db833880a187f5ee",
".git/objects/44/39a248e0509cbdb3053becaa6abf59bad6b313": "757bf6a8700392c8e04b9f66a6eff1c8",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/7bb2b9522efe4933a2f5ee8b0e767323fdbae0": "a9eb8f628b101408b66155dedaedae58",
".git/objects/48/bf2126f430e040ef0163c8c87642db709ab7ef": "9500b5badc09ec85f1cbd94c3088b4b1",
".git/objects/4a/53d7fdc614397708a3a76bef0df63b40889cba": "0b6fc3a9d9adda9ab15a7295db0a4dce",
".git/objects/4b/e034e3d4959831b27660f0c092e49a86c9459f": "27da58946b27c1d1dd3b1656939c15e4",
".git/objects/4c/5bd76b979175ad501eaecfb3063b9d988e9ebe": "96a1649efe460e424742307ee42f28f9",
".git/objects/4c/a2a7c226d2c3e26f0b9dde74214486d0baa896": "734657b1f27c72d07dd9e52a25c020c1",
".git/objects/4e/1701b67c47cd4ffaa8fec2b8642d6760bdfd43": "b07a55788528229f5d8bd8d1fdd68e3d",
".git/objects/4f/941bd593a0ffd85af16453c8f9d6d4860bfb80": "afef62c231bf216f21c6b9c5f9db2d1f",
".git/objects/50/07a59505a7466e42908dce5e6b095cd02a5694": "1b0a20037a79756c69fb0c363746efe9",
".git/objects/50/348aee58456e01d7b534fd273887fa5db7e478": "35b0d93113121dec86d720e5a89c6c73",
".git/objects/51/723da14a2de67960cf7f9dc3eaa1f491695e9d": "26932dfa637f5276d283a6ccfc1b216e",
".git/objects/51/bba6b81ada941771c8b17f7f950a482b6b73eb": "f7352edf08f8adc85024c1ea784b324c",
".git/objects/51/d43cfd5b2b8e44f6144e70762ab8a4cd40413b": "0bd4d6b412efe8559a045183e1124280",
".git/objects/53/39de5618a0f06f0a31ab5ebae5d0067a856b90": "52d647e2e4a83bbf16f2686a01f3805e",
".git/objects/53/7807567919e88db2866b7825339c57e94c24d8": "970aec5149a3dbe9370a9dc982cdd022",
".git/objects/55/a87733f56dc24389e0cd3706e0024ab2ebca37": "ad1de1a4a140a86ed7fe3d9e94d113d2",
".git/objects/57/8c07433ba07fe5a88f3907b5d901f8a8ab4f55": "c240b52223436183cabacc737ac1e05b",
".git/objects/5a/ea514182120d8ec79da592b21d82fffae17b6b": "a0c5b6d0ba10d95d9805832211ff4fd7",
".git/objects/5d/3354c937ca328b0019980ad54ee588611e839b": "4d5cac63cb5117d7c346cca8d8e6f3b6",
".git/objects/5d/8ad40fcacb6ee1d268d649a03f766506dd1373": "0a713e8908b0cbc0f6c127ccd34ffd4a",
".git/objects/62/25775b4676bd5e768c0742012ab8678165b425": "ca96e44cbc45bc35fc1c2eee68afe3ae",
".git/objects/62/425862ac479628c3c00659fb6f31420cb3de0c": "a066b91b55259969345eef3be3c0dc74",
".git/objects/62/6ebec5c00ce8cb41f1a24e9d4bf5310a397452": "761f1159fda405eea1579e2b81fd2d5e",
".git/objects/63/2e43cae114f539a6e76530b5aa63c25674475f": "719ed8ccb10bc67eccb088c9fe5001e1",
".git/objects/63/870214501aed2e183b89cb6ac52c7a6b46c9a5": "092aa08e6b4976c31d74bc994003c63d",
".git/objects/64/ac88474c1e0ce2d5f757ff5db33a54dc556d7c": "a9e891f97550c93434204c7bb17432bd",
".git/objects/68/26f0fb065ceaadf7f4ceeb74af04e569f71149": "793f8e8179c4ea895a7f1f9a861bd501",
".git/objects/68/3c8c46c921178c7a16e85b4fb6e1d4f140ac44": "17044091e16e02c30b93227ca2aebecf",
".git/objects/68/c8b8c3910c49505e0b92780bf95dfe3f0a1ad1": "9babb595cb925789253ecdcdfb700143",
".git/objects/68/f96bd0dae4be6771a17929f220b18e1025ed10": "e32a089eb50c88c9d9523d74ee566d7a",
".git/objects/69/24e7601b43c769ce12b122eede94e1e1fc2dcb": "03445925f458068b39fd42c6fb1a2661",
".git/objects/69/7f290aa1fa707d3c034c35fe22dd64ad56eabf": "e0c3b1b50f9b03f8ad903a0356d28bbd",
".git/objects/6b/d22c207e4be37235418205e4bbca44edf8b249": "f77467bb49f1d43eba580fec0ff7ad73",
".git/objects/6d/416e16f17bccb35c2a75fc99cc9fea69915dd3": "cd765da531e30f7b14688b96da7c5254",
".git/objects/6f/246b21652b8a3f86a05427af3ec14328a5f7e9": "b55e6501b71d75c85227dcfb612541a0",
".git/objects/6f/4684e083a018fb2b9b3e3579fa83d88e00357d": "c36a0d2885d9ce067027d762572f1a49",
".git/objects/70/cdca4181e92dca87ab07bba233c3d29fa80b0a": "4f62ec64c9b79a36bf5efd48d8471694",
".git/objects/74/60025ef94ca71c0d8e2976c756bb5ac7a8014b": "3500972ab8fee1cf8b98a0e55a0468e4",
".git/objects/75/5519a56b0fc5a4362f31e6a4ffe4e896e3f8bc": "dfa243991acb8b9ff5b2195db23b451f",
".git/objects/77/b0347db3c7be1df1fcefe70603700e66849bd8": "a59e4987f75f0aeb7f7a5ec465c90a9d",
".git/objects/77/d7b355d1d27519454a94613b062ea5c4650c30": "1101780d234ff3d0b5046d3e2e61f5f3",
".git/objects/78/74e1315bd082987d00b1c4cc7561ab1b6a11ad": "e244f5556792e4b5e1c7f7dfc252b076",
".git/objects/79/3be0c35b944f304c5522ddf500ec5f7213bd0a": "f8614f03b78bdd0c5ba94225781e195a",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/7a/c2ba37b5bd3eecad2966caeb1da17ed9292c31": "83232c449f66fe79f9b110cc91dda1f5",
".git/objects/7b/c4f6ac14721734a66ef40a04ccf90bc456bb4f": "9ed190ea473b16c96546a0b4f0c6ee56",
".git/objects/80/a22d3969441ac33769b84d965048167c3a4c51": "49a0dbb10440bd9ace42f576a4844e21",
".git/objects/82/272ecdf07bbd999ebbd009b0365d42169e115f": "42956256c0c4c90458858817148ce139",
".git/objects/83/0e3d19e7f2ff19bbb4b955e3a38e3328837e12": "4412f19a8aebd49e1c2fb821b641e232",
".git/objects/86/f9d6eeeb9fb3fa9f5c7437d0da6f8aa16057d6": "f56e5e65ef728b9909481b44d539f70e",
".git/objects/87/00c32a769632395326c87ee14c5427b65544e7": "a4e40889f22c1603850d0c613f7e9d1e",
".git/objects/88/59981763e9f70f5384f3e18602bd137bee008c": "ef015353b475fe2705d0eb8e0daa3eec",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8a/f1a5af4e3ec6a94d768d11bbb2830589ee5f39": "75ee4d1164194e1cbc26bf039dfcdfdc",
".git/objects/8c/99266130a89547b4344f47e08aacad473b14e0": "41375232ceba14f47b99f9d83708cb79",
".git/objects/8d/4580e5911055da8bfca7325396b090b01f0fe2": "32cb1ff7657aa80e99b7ec777451c895",
".git/objects/91/c534d010956aa8610a283744018538a3944c60": "98a715cadb606cc3aa26873bffd16ed3",
".git/objects/92/20479715fd05aaf2449ca26d2e0b28e55fcc5e": "90ad068f7de4bd226c13c32154bd1883",
".git/objects/93/caf17be619b41f0766355d7576d3f75a3d7a05": "15347dc7e57d833212a7f2edb857cced",
".git/objects/95/8f16cabe8884348cdb8d1002ae63035e436995": "5d1b3d66d5e3aafd4ab0897bcad485f0",
".git/objects/96/5497cb37d805b472d4b97e1837e6234c8e8dfa": "26025791bade34532cac55e549acfb42",
".git/objects/96/5f268e91b7f468ea4ded85a8f2abcddfe1f5a9": "6cde620475753acf951a3fbb6b42aca1",
".git/objects/97/55541a45c1c70acc0e0d55d36c95a1c9496037": "c126d758be9e0d22eeca786dfaaf8576",
".git/objects/99/4c1bc0450f3972ced2bcc134ccbd17895e0b8d": "7c8e7c733871eb5584e44fc402883381",
".git/objects/9a/04c128e08586d3fa16cde39fa8d6b3167f1e3d": "ed607e1a8ac782c402cc3ceae646c012",
".git/objects/9a/cd02114baed388630780e1f5740fa4b29bab89": "edd5e2d5847575add6da74476d70dc47",
".git/objects/9d/5f886353dcff6c222439cc1118e77eb1b007ea": "a87ff240c6e149d1ce495643e49417f9",
".git/objects/9d/adff9b48a91847100c2fd15913f3184bae1549": "fc6f48b956faa7b565548ef01044fc08",
".git/objects/a0/7c5063a9aa19f3f559f71e8ed39935eba6a2fc": "87871ec3d8f02a47bd5a770508f9fc94",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/a1/9c24cee800a4fb306d2b27e94650a2be2c3ca9": "3aff508dcc7460a216ee9abaf7c0baab",
".git/objects/a2/62ef1980970ffddab05618efd736341fcc3b01": "6a39ebf20b11397d2d80aef4e2a0964e",
".git/objects/a2/cacce267b84f18fa1cf8dc03a3d3513077897c": "8964dc8270636ef4b73ee1a46133ead7",
".git/objects/a4/0174886ca13a29d1e39e0bb6862e668b9d9ba9": "847933cbf3e2f639790e0e3d9a10a2da",
".git/objects/a4/76cbb5b5e4bda225678e3811e3bffed92c7d78": "054052aaf99a855ef4e1106cf3cb6691",
".git/objects/a5/ff9cf2a3aba14288d8b663d761071b6f8d7dac": "4d5c623252596694dab60567927d93af",
".git/objects/a8/234e78324011301c932efde8dd789fba10495a": "5ad9ca983e505191e13f526cf3be6ade",
".git/objects/aa/263351adfe2f3e1c72fa942d0cbd937c49ac30": "d48725627dd8823a9504511cc1f37d1c",
".git/objects/ab/0e98497a51ead7821d1da35a24968ff314e50f": "557c35fe3928eb2af403d1b3926bb9ba",
".git/objects/ab/836dc3c3ee65992368980bf12b16437a8ee2cf": "5ce2f75d354c2d7e6b8f061c95563a42",
".git/objects/ab/8e830dd7eb29232a283f20c346d5e47e9e1d87": "b0274b7f94696b4ecac8f39a4c2bd62d",
".git/objects/ac/956c8ccc1db0960f13210eabf8177e56856cd2": "caeb32593898df2f7fe46c974aeae812",
".git/objects/ad/70faafdfb20cf266ed17402382f588223a7533": "8e715d9b8dd15c2bdc658c028d025109",
".git/objects/ae/a5f44f1ef04828946fe819b2c060b9d5b1577f": "00337d1509c7d8c542657364dc75c513",
".git/objects/b0/504cf3ae9ec9f774ffaa1f0309f0a6ee31b86a": "30ff47004db50cdbe6e13ab1ad95cb8d",
".git/objects/b0/b54127bdd8e337f8da1397aee4aaab98c5e066": "319d7981b065036eacc8c107ebf9998a",
".git/objects/b0/c619cd0b1fc8a22cea51faf424fdf1c7e49f65": "a960a70c9c3a1407f54b0564373f8b1b",
".git/objects/b1/237148eacf10ed7e3c884be1e57678da2fbfec": "617c17c8aa1ac805661e2fd0d0e9d5e9",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b8/01e588fbf06552b0dfb15434590bb786c14939": "8d86b596d46940383f3a1649ef7dff96",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/1db166fc702484168cd91eed8922962b78bd9a": "480217960b577347ca9964beb9331d3c",
".git/objects/bb/ac29f5ef7a40bf14c0901bc1457724156bc0de": "1393f20f0610cabefe2d4f45865b0f54",
".git/objects/bb/b269e13fb3b284357c0017bb8ad3cfe2941a38": "8f4907398da047f5a1cecc4150c733f9",
".git/objects/bf/3a586acc222da5ad70a0571853b38d13b50432": "1a7b380417f4fd8cad84ff098fe5d734",
".git/objects/c0/7ac4af924cd0e8b821e1c4abd49c5baf252709": "df56ce17d90731b437c4af42dc151ce5",
".git/objects/c0/fb9d231ed6514a7e5a3c2c68b28c5f57b68f43": "a6488bd139637ff8c85c2ad9dab9cb22",
".git/objects/c1/c814ebb523fa4efd4c144e794685fd777d2d7f": "aa819bbe041d3819114b38ae55890e0e",
".git/objects/c2/d8d2f44dd987786bbc249d4ad7bac3360f4811": "1926a57b256d9def261ccf6dc2914f65",
".git/objects/c7/6d0d1a4e4727948ea307e43bdffed59111d876": "694fe27f3962670732cb396d0608fa28",
".git/objects/c8/e64cf46f9abdb2b8472dd696f55c1110841d95": "3abbf4a6a3dd8bbca33f49ae087bff61",
".git/objects/c9/200559d262df7c27f87e5b972771f8f50ee6c4": "0bf75cb7235c9894bb562949b5c71962",
".git/objects/cb/88258e3a6d9ce0ad726f9356204712def131a3": "163cb5b0b8d3f2fc7ff0ec63055a4e0b",
".git/objects/cf/912307fb52290dfa425519ef7e203ed55e4f36": "a634290a7c6e55d480c1cc30abd1dcf8",
".git/objects/d0/329c2010c45b03126657b3bacafc364514c42a": "21110cc26f4b8c513a6a1bb2012cdd7b",
".git/objects/d0/f3f0a2fdce56cf157ed4c2eb921ed987b916ca": "79e0d0093005e86fa5ffb0029273f99c",
".git/objects/d1/ec5ff494a3ba74574531c3fc78fb69ea619f61": "158be98607d557a22e61353ac17dc8a5",
".git/objects/d2/95fd52d0343565abdbc84abec859772aeafc56": "a046665bf06f113d7ccc40ac085ccfa5",
".git/objects/d3/1613f9e8d6d75474125f5cdb44ecaa116e479c": "5db4f9a936a9d66e2ee9b1d3eb35434e",
".git/objects/d3/e04c03d4a3462943329576da2fec61898ae23a": "d7b1fac2612e81d30bcf2089a5838c5d",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/d4/1d026988ea8a48b09f394daf7dec70d96c6183": "6e5172c0d1d3f8754cff10b42518aaac",
".git/objects/d4/bd3f0a43330aa9c4a0fe1c81eb65137b069fc0": "261116679160be61c63a0819c8f73ddd",
".git/objects/d4/bd42ec12714f2fed73cdcf1cff387688df4f8a": "d7d28fb6d481b00b5048d49f67cd60a7",
".git/objects/d5/b54bd4a898b373f82bb1fa52b9580e7a976e3e": "943e27e1d359e2bc22daf20c70287c19",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/2c11112c7cb4e2ce754bc41470f9b829a2d00a": "d7280a766a5d6033f187d874a92b5ad6",
".git/objects/d7/e7df748c9d7879aa3e2b9e4226beb9e7478970": "94ec0fa78380def1c37df76b7710198a",
".git/objects/da/4cf68ca003d319be2bb650851783af0d8b1792": "f514300193099983019ebb0ca548e7d1",
".git/objects/dc/bf629f906760eb36b4abc24b49ebed584108ad": "57030d75d2aca6c72122981d1d656316",
".git/objects/dd/51c916863f5a8beb095b52012bddfd55576688": "8ccfc99ce0e4301314b8aeb98cf340a1",
".git/objects/df/7d2dcb89ab89da87467c0e1059b38c8d8f9296": "a44162ff357b024e4638ab18a9bb01c7",
".git/objects/df/e9f47b6bf37e7bd52cee70714c51a91e4522ae": "65653ba23f8f02f181d44713f164cd4b",
".git/objects/e0/49c81f7cb35ebc411a3e1b547bf4ccf91292e8": "efad70dc0ca77a90ee53b5cc3be528ca",
".git/objects/e1/48185b49613b9bed1ace06dec8a8d2e5b9128c": "32cacc968dc34252ada0bd7227713ae1",
".git/objects/e2/ff5865b192241d53935e77de70a4e6dff2847a": "cad1058aedc6c21a518b3cb00af21fac",
".git/objects/e3/99040a6c66641b1064aa5bbb637285a2aede76": "c79fec471745f95858b6f51f209c33b3",
".git/objects/e4/31453a092dd64af891a747df21fa6084076c48": "abd616ca21f495fc62d54e232abade20",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/e5/f489b64ffcb5dae3b40393dfee42a60be6e8b9": "d40ce3b2ab079b15bc0fe7c9301a6a32",
".git/objects/e6/46d591f99adb142edab348e5d728ad2bddc4a3": "7630b34441d494db3bf4d884cd250e72",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e6/b745f90f2a4d1ee873fc396496c110db8ff0f3": "2933b2b2ca80c66b96cf80cd73d4cd16",
".git/objects/e6/fc86ea0d617c76f05940d7647acf8d96062cd5": "0873674076dd777f5a5c43c7c84ba639",
".git/objects/e8/55dc987b0db3ccd24a8869a087233a0e124f27": "9b242467f4dfe05ce7d2727a68a1ea66",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/86965ec71223c82f94089bdde81f85cda3548f": "f0ab28039a60474fabb8f6005f576327",
".git/objects/ef/7bcc57476489873dfac037d65b33fd3e40a58e": "6a5e1128539ea85d436d881bcc50c7ed",
".git/objects/f0/53de0b6214bf6a1c8ae50548166aab705e0bf6": "44ecd281817194f046f083494b1305c8",
".git/objects/f0/8b861e6b8965e68553ae00f23ba424a5b70461": "407a76b3524a6e96e81a14aeb09378b0",
".git/objects/f1/774d78010691ae0f16343b8f942c3ea20ae861": "56f233ce428bdfa02d261a3961d7f740",
".git/objects/f2/baac15fe0d97ed761706b42e528c0ad62d0342": "91011f72c2d37e0c7372342ab10e1bb4",
".git/objects/f2/c81a05fa4cf4d18c3a6d39e816ae362ddbc91c": "c377bc24d0ac77955c5ccec46505d2a3",
".git/objects/f6/40839565a68bb4a73eddb46da409aa58d3f0a0": "e50ff13c0b8c39de82ea118098807dde",
".git/objects/f8/6783c7e06ca5f0d50499e4b8710dddf9af6e93": "4c5c83c61cb7f8caea7d9526c479c894",
".git/objects/f9/4b65100cb85beaa140d3428bf384da03a18cb6": "80c737779178eaf97d6ac88562d0bec0",
".git/objects/fb/a60acfe37b83f206efab0e4235cca3080678dd": "29c582edd92df7150658e625d2e52bda",
".git/objects/fc/2c90e04c6ccf7fb24e393d6303e2ec8ae284b7": "d4c3e67513c6e3fba082b19e0a747fa7",
".git/objects/fc/de1bb3df8c330568f07ef326d43d8ae3562897": "6e5bf2450330342c243afc3723b9c27e",
".git/objects/fd/6f834f439d5d4d249bc7f65a3e193e6a1701ce": "c1932b860f8fdb32b298c9bd488a79ad",
".git/objects/fd/b4f4a2d68a6faced07a4f225fb98e73c41fbdb": "6545ceb7fb0bb07b5b262282d730f652",
".git/objects/fe/410cc93638e0e1fe838248e87cfda6daa07f1e": "79c4f6414ee99fff9de90aeea0ee2abf",
".git/objects/ff/36db7496babba936a7da442d2e5fe2d8ea1470": "dd12e8f4cd800ded49a052cfd7cefa24",
".git/objects/ff/3ec1c1f7e858c03e6890569a3d2349b82c6472": "b1ba9643e3b40d499c4fbcce927ebc12",
".git/objects/ff/743f414cd32a3b10090692ff176e0efd9f26d7": "43196c7c7f49717eb12f625aa89ea39d",
".git/objects/ff/fb757c34d7268669514eb7b0a45cf7a6bdc357": "ddf719aeab6641ac9f7f64499679b9c7",
".git/refs/heads/master": "66a38001375b9fc4355acc1bb59b3db0",
".git/refs/remotes/origin/master": "66a38001375b9fc4355acc1bb59b3db0",
"assets/asset/image/description_img/1.png": "446594db73640925d52077feb39e4dd3",
"assets/asset/image/description_img/2.png": "f63a62ad1b018df15e49a047f6d74de3",
"assets/asset/image/description_img/3.png": "2f7583112155182def9111e79ee8d9a5",
"assets/asset/image/description_img/4.png": "beb9d7aded09d23a2295cdc4f561c658",
"assets/asset/image/logo.jpeg": "d2d301607a5312047d075bef721b462e",
"assets/asset/video/bee.mp4": "00828658bda7d312c96847564c319842",
"assets/AssetManifest.bin": "baa48308e3032c67d7caf133abf2625a",
"assets/AssetManifest.json": "521386519bb3bbfdad7243e89881f667",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "88d16af73ea0a46a66c86045383821c5",
"assets/NOTICES": "d6630e6f283e21bb0b7330bf9bb204b3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "a56fbe9a39e0352fd01bce250458ee0e",
"/": "a56fbe9a39e0352fd01bce250458ee0e",
"main.dart.js": "6dedb4b8966df3b2b033c8e24d94d71d",
"manifest.json": "bd88566df30c2903ed698ad4c0428e10",
"README.md": "f1d9a68adeee2a9ac3ad754443dd12e6",
"version.json": "79b424abf6d1a5a7085582312d40e29a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
