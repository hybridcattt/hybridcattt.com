// https://www.30secondsofcode.org/blog/s/copy-text-to-clipboard-with-javascript

function copyLink(url) {
  const el = document.createElement('textarea');
  el.value = url;
  el.setAttribute('readonly', '');
  el.style.position = 'absolute';
  el.style.left = '-9999px';
  document.body.appendChild(el);
  el.select();
  document.execCommand('copy');
  document.body.removeChild(el);

  alert("Link copied successfully!");
}