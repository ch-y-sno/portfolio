// document.addEventListener('turbo:load', function() {
//    const fileInput = document.querySelector('input[type="file"].hidden.upload_image');
//    const form = fileInput.closest('form');
//  
//    if (fileInput) {
//      fileInput.addEventListener('change', function() {
//        form.submit();
//      });
//    }
//  });


  document.addEventListener('turbo:load', function() {
    const fileInput = document.querySelector('input[type="file"].new');
    if (fileInput) {
      fileInput.click(); // 自動でクリック
    }
  });

