'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/asset/video/bee.mp4": "00828658bda7d312c96847564c319842",
"assets/asset/video/Chopinetudedae/phrase/data0.mp4": "36d9b4955e4b8ef019caa896fb00fd79",
"assets/asset/video/Chopinetudedae/phrase/data1.mp4": "735a59f38783930dc4d2a5d0b6761749",
"assets/asset/video/Chopinetudedae/phrase/data10.mp4": "b63ae06557872406d93c9d131b249db7",
"assets/asset/video/Chopinetudedae/phrase/data11.mp4": "f73fa7b3edb0d979def4b6db27e0795c",
"assets/asset/video/Chopinetudedae/phrase/data12.mp4": "30a21bc86fff658820813cd365fd8f82",
"assets/asset/video/Chopinetudedae/phrase/data13.mp4": "fda43eddfff5ab0ca7941ff7014b9da4",
"assets/asset/video/Chopinetudedae/phrase/data14.mp4": "be6475ce0b6c84f8484425d504202f27",
"assets/asset/video/Chopinetudedae/phrase/data15.mp4": "448e391902c6e123078b599fba496024",
"assets/asset/video/Chopinetudedae/phrase/data16.mp4": "fabea5cbee724f893565fc9d578d1c15",
"assets/asset/video/Chopinetudedae/phrase/data17.mp4": "1003158451c76863d0819ac27b8c43bb",
"assets/asset/video/Chopinetudedae/phrase/data18.mp4": "818460096903db4ac8932cb5ba72ae03",
"assets/asset/video/Chopinetudedae/phrase/data19.mp4": "6745db937b4c9c7fef5159435ec07645",
"assets/asset/video/Chopinetudedae/phrase/data2.mp4": "c9a8df896a5c128aede91f3c2d33bd76",
"assets/asset/video/Chopinetudedae/phrase/data20.mp4": "118127e20df9bb96106122191a078ce3",
"assets/asset/video/Chopinetudedae/phrase/data21.mp4": "a05929ca131ac5be53cdf823308e6c41",
"assets/asset/video/Chopinetudedae/phrase/data22.mp4": "a3b44bf9fb0712ec1e6731685cf35ac2",
"assets/asset/video/Chopinetudedae/phrase/data23.mp4": "bcd60b1bb1e5719e689fd064385b2a30",
"assets/asset/video/Chopinetudedae/phrase/data24.mp4": "221c4478c92142989a9058048fb7e37e",
"assets/asset/video/Chopinetudedae/phrase/data25.mp4": "473f0ce22961044d3ba51e7cb845e7e8",
"assets/asset/video/Chopinetudedae/phrase/data26.mp4": "9957dfb42b3a6236c3f7937a8819a559",
"assets/asset/video/Chopinetudedae/phrase/data27.mp4": "6a33302b15a7ac32fc42ebdec87022c7",
"assets/asset/video/Chopinetudedae/phrase/data28.mp4": "90a15dafe2174c5b9140f8a5ac9a3ee5",
"assets/asset/video/Chopinetudedae/phrase/data29.mp4": "911bd353f43716952dd9d692a353ffcd",
"assets/asset/video/Chopinetudedae/phrase/data3.mp4": "92b5e6997f6b83f7127f95978b25eab7",
"assets/asset/video/Chopinetudedae/phrase/data30.mp4": "df36f54dc825857c57b302e3de1b7685",
"assets/asset/video/Chopinetudedae/phrase/data31.mp4": "d3a9324f83fa89b8a84f13cd6e1deee7",
"assets/asset/video/Chopinetudedae/phrase/data32.mp4": "3d44a313644c1774fc6f120706eb9db1",
"assets/asset/video/Chopinetudedae/phrase/data33.mp4": "c5f6275498ef21f14f1b0b12914c66fb",
"assets/asset/video/Chopinetudedae/phrase/data34.mp4": "9804c28ca13db85147a2b6d592c7e317",
"assets/asset/video/Chopinetudedae/phrase/data35.mp4": "30f22c29ec19c7f149dae3a2989a255c",
"assets/asset/video/Chopinetudedae/phrase/data36.mp4": "13b16703d11577b3dca3098bb04ba777",
"assets/asset/video/Chopinetudedae/phrase/data37.mp4": "1a234cd35db553b6495af72427bc3f6d",
"assets/asset/video/Chopinetudedae/phrase/data38.mp4": "204ce7b0576644b222edd8c433ceee39",
"assets/asset/video/Chopinetudedae/phrase/data39.mp4": "6233c91ef2f9b997ddfc24141ce33418",
"assets/asset/video/Chopinetudedae/phrase/data4.mp4": "f0970669ccb2e14fe51af4b093aa228b",
"assets/asset/video/Chopinetudedae/phrase/data5.mp4": "4a210637344919822d2b1a1e85e020d0",
"assets/asset/video/Chopinetudedae/phrase/data6.mp4": "f66f52fe415167f6629bfac5e7723e6b",
"assets/asset/video/Chopinetudedae/phrase/data7.mp4": "951c09b1ca9ed3085639f3fbd0abf4b1",
"assets/asset/video/Chopinetudedae/phrase/data8.mp4": "049e60f05379e7d86f46a3c6611cb48f",
"assets/asset/video/Chopinetudedae/phrase/data9.mp4": "890fff4cfb7d96d530ed2b0d9e01a61c",
"assets/asset/video/Chopinetudedae/phrase/phrase%2520data.txt": "4e76152d30deaa79f63aeb06304a852d",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data0.mp4": "c3e22e2f11954ea49fd1b9e235a060ce",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data1.mp4": "4f5d420404680ad590019015554738f1",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data10.mp4": "ac8e2444a0a307ff5dffbac0b9cb3c4f",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data11.mp4": "188f0f66bec547b2b3f5b7d80d30f82a",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data12.mp4": "f0dc555c6fb47736e755d53cb6857094",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data13.mp4": "01c9529566efa6a6699c4afe25064365",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data14.mp4": "eb9bb376ae53c3f776ee6856685b1a1e",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data15.mp4": "0bb72ef0f0adf6006bd9b57189c823a2",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data16.mp4": "1b57502a518d5ccccc1352d046aeffc5",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data17.mp4": "bcc7ef37001a03309a12a44c3a780287",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data2.mp4": "5aece3b7deb302942ba4ec107d392a81",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data3.mp4": "77583f8850eadf0a46ef6b99ed6fef1d",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data4.mp4": "a441ffb67f75b092cba5376994ac98b0",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data5.mp4": "a06d418fd9804e58000a0824e4b55885",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data6.mp4": "8c35df83b0580b8294999ffed3deb9ed",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data7.mp4": "acd8d2d0cb525ee19da728e44efa3dd5",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data8.mp4": "d60371e94ac1f7f6b21bd085d83447c1",
"assets/asset/video/Chopinetudeop.10no.1/phrase/data9.mp4": "4c42bf76a548add6b4541a932a7ab4bc",
"assets/asset/video/Chopinetudeop.10no.1/phrase/phrase%2520data.txt": "f6ec3810a218c0fe53d93eb9ec9823cc",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data0.mp4": "04cb99faa67c0e4bb5b6dc0c8dd32c02",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data1.mp4": "92073cb1cb626eda629b7fb9bd2b0bb0",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data10.mp4": "161d7b954657f31009004ab9b12266ef",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data11.mp4": "caace0364dff7381373551a36ca394d8",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data12.mp4": "e38280f3f431205eb6d762418241b68c",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data13.mp4": "e3274386348f359fb9639c08fb326d64",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data14.mp4": "b45a8f075522334af765220c32129650",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data15.mp4": "402053e22d02dfff03940e97567c5aea",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data16.mp4": "775e757d167f4b094f7712c3c8b304b5",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data17.mp4": "86819ca0c536cfdfdc884cf395442c46",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data18.mp4": "b7bd94e6dda6faf1aba3fab090aed8c3",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data19.mp4": "d0fcef4472defa22211c749e9ec2c1bd",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data2.mp4": "ad9711430e0724dfac2b0c7e6aa85d81",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data20.mp4": "d1aabd73a2ae39d79088c774da89f025",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data21.mp4": "43a48c7e694ea8cb7c9407f994d292e2",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data22.mp4": "5a41d4c6d5630d7d3789e8d4d2309c26",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data23.mp4": "052689cb8b544731b214e17b43fb3604",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data24.mp4": "23d680a6b43a52a4c6942bded7ff2744",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data25.mp4": "a52f828cd8bd806ffec74b960078b6fb",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data26.mp4": "aafeb4d88e37f9886df2f71e0f3f2607",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data27.mp4": "0da310b8b186f5eabbc3a2c188eb391d",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data28.mp4": "47bbc75932c534ce274d46fe970715fe",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data3.mp4": "78f9fdb1e7d854a96f400d4880dd503b",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data4.mp4": "5d6c8775a57ec442b58e74ba96198b36",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data5.mp4": "ea553ad67bde7bd48ff1324be0a33aa3",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data6.mp4": "0939e4ea4178aa3da582b762a45385d2",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data7.mp4": "7463f4692e6b8068d1a3c48cc02a7129",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data8.mp4": "c6eed016309983fd6718cde513abb5c1",
"assets/asset/video/Chopinetudeop.10no.4/phrase/data9.mp4": "3445c0eb266cdc5257ba7f2e89949871",
"assets/asset/video/Chopinetudeop.10no.4/phrase/phrase%2520data.txt": "6a5b6a2b37cb0cf5ca39558ab45b6f53",
"assets/AssetManifest.bin": "1948ab8dea15be4f433834b478e371e3",
"assets/AssetManifest.json": "97cd4427356fa283800f16c5da9ec83b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4535c76ed1dcfc09352cc4211ef3b59e",
"assets/NOTICES": "7b59b8953ffe9ba8cc09fb97f4602c4e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "98e4293860bb98506759eba8e96b3fc1",
"/": "98e4293860bb98506759eba8e96b3fc1",
"main.dart.js": "d15f20c332351e3ff68eea3323ef10aa",
"manifest.json": "bd88566df30c2903ed698ad4c0428e10",
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
