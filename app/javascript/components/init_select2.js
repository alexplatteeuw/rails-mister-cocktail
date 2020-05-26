import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  console.log("test2");
  console.log($('.select2'));
  $('.select2').select2();
};

export { initSelect2 };

initSelect2();


console.log($('.select2'));
