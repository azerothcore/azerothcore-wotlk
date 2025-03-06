#include "Utils.h"
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

std::vector<std::string> split(const std::string& str, char delimiter)
{
    std::vector<std::string> res;
    if (str.empty())
        return res;
    std::string token;
    std::istringstream tokenStream(str);
    while (std::getline(tokenStream, token, delimiter))
        res.push_back(token);
    return res;
}
