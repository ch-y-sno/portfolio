document.addEventListener('turbo:load', function() {
  const fileInput = document.getElementById('user_avatar');
  const preview = document.getElementById('preview');

  fileInput.addEventListener('change', function() {
    const file = fileInput.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(e) {
        preview.src = e.target.result; // 選択した画像のURLをプレビューに設定
      }
      reader.readAsDataURL(file); // ファイルをDataURLとして読み込む
    }
  });
});
