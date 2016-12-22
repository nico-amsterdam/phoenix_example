function uinames2contacts(names) {
  var email_result = {}, 
    result_list = [],
    transform_names = function(item) {  
       var contact = {};
       contact.name = item.name + ' ' + item.surname;
       contact.email = item.name.toLowerCase() + '.' + item.surname.toLowerCase() + '@acme.com';
       contact.value = contact.name + ' <' + contact.email + '>';
       result_list.push(contact);
    };
  names.forEach(transform_names);
  email_result.contacts = result_list;
  return email_result;
}
