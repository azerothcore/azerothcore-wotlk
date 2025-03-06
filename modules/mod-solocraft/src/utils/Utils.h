#ifndef UTILS_H
#define UTILS_H

#include <cstdint>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

std::vector<std::string> split(const std::string& str, char delimiter);

template <class T>
void LoadList(const std::string& value, T& list)
{
    std::vector<std::string> ids = split(value, ',');
    for (const std::string& id_str : ids)
    {
        uint32_t id = static_cast<uint32_t>(std::atoi(id_str.c_str()));
        list.push_back(id);
    }
}

#endif
