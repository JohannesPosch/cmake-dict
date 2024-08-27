# CMake Dictionary Module
This project provides a CMake module that adds dictionary-like functionality to your CMake scripts. It allows you to store and retrieve key-value pairs in a dictionary structure, enabling more organized and dynamic handling of configuration data within your CMake project.

## Features
* **Dictionary Storage**: Store key-value pairs in named dictionaries.
* **List Storage**: The dictionary can store CMake lists as values. Semicolons (;), which are used to separate list elements in CMake, are internally replaced with colons (:) for storage. This allows lists to be stored and retrieved without additional string manipulation.
* **Value Retrieval**: Retrieve values from dictionaries by specifying the key.
* **Graceful Handling of Missing Keys**: If a key does not exist in the dictionary, an empty string is returned.

## Usage
### Including the Module
To use the dictionary functionality in your CMake project, include the **dict.cmake** file in your **CMakeLists.txt** or other CMake script:

~~~ cmake
include(path/to/dict.cmake)
~~~

### Setting a Key-Value Pair
To set a key-value pair in a dictionary, use the **dict(SET dict_name key value)** function. This function allows you to store a value associated with a key in a named dictionary.

#### Example
~~~ cmake
# Define a dictionary named "my_dict"
dict(SET my_dict "username" "john_doe")

# Add another key-value pair to "my_dict"
dict(SET my_dict "email" "john.doe@example.com")
~~~
In this example, the dictionary **my_dict** will contain two key-value pairs: **username** with the value **"john_doe"** and **email** with the value **john.doe@example.com**.

### Getting a Value by Key
To retrieve a value from a dictionary, use the **dict(GET dict_name key variable)** function. The value associated with the specified key will be stored in the **variable**.

#### Example
~~~ cmake
# Retrieve the value associated with the key "username" from "my_dict"
dict(GET my_dict "username" username_var)

# Print the retrieved value
message(STATUS "Username: ${username_var}")
~~~
In this example, the variable **username_var** will hold the value **"john_doe"**, and the message **Username: john_doe** will be printed.

### Handling Lists in the Dictionary
The dictionary can also store CMake lists as values. When setting a list, the semicolons (`;`) used to separate elements in a CMake list are automatically replaced with colons (`:`) during storage. This allows the list to be stored as a single string while preserving its structure.

> [!IMPORTANT]  
> The colon might not be contained in the original data, because it would be changed on get.

~~~ cmake
# Define a list
set(my_list "item1;item2;item3")

# Store the list in the dictionary under the key "items"
dict(SET my_dict "items" "${my_list}")
~~~
When retrieving the list, the semicolons are automatically restored, so you can use the list directly without any additional string manipulation.

### Handling Missing Keys
If you attempt to retrieve a value for a key that does not exist in the dictionary, the **dict(GET)** function will return an empty string.

#### Example
~~~ cmake
# Try to retrieve a non-existing key "password" from "my_dict"
dict(GET my_dict "password" password_var)

# Check if the key was found
if((NOT DEFINED password_var) OR (password_var STREQUAL ""))
    message(STATUS "Key 'password' not found.")
else()
    message(STATUS "Password: ${password_var}")
endif()
~~~
In this example, since the key **"password"** does not exist in **my_dict**, **password_var** will be an empty string, and the message **Key 'password' not found.** will be printed.

## Credits
This repository is forked from [nicolas17/cmake-dict](https://github.com/nicolas17/cmake-dict). Special thanks to Nicolas for the original implementation.

## Contributing
Contributions are welcome! If you find any bugs or have suggestions for improvements, feel free to open an issue or submit a pull request.
