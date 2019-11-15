//
// RecursiveDirectoryIteratorStategies.h
//
// Library: Foundation
// Package: Filesystem
// Module:  RecursiveDirectoryIterator
//
// Definitions of the RecursiveDirectoryIterator stategy classes.
//
// Copyright (c) 2012, Applied Informatics Software Engineering GmbH.
// and Contributors.
//
// SPDX-License-Identifier:	BSL-1.0
//


#ifndef Foundation_RecursiveDirectoryIteratorStrategy_INCLUDED
#define Foundation_RecursiveDirectoryIteratorStrategy_INCLUDED


#include "Poco/Foundation.h"
#include "Poco/DirectoryIterator.h"
#include <stack>
#include <queue>
#include <functional>


namespace Poco {

// STRUCT TEMPLATE unary_function
template <class _Arg, class _Result>
struct unary_function { // base class for unary functions
    using argument_type = _Arg;
    using result_type = _Result;
};

// CLASS TEMPLATE pointer_to_unary_function
template <class _Arg, class _Result, class _Fn = _Result(*)(_Arg)>
class pointer_to_unary_function : public unary_function<_Arg, _Result> { // functor adapter (*pfunc)(left)
public:
    explicit pointer_to_unary_function(_Fn _Left) : _Pfun(_Left) { // construct from pointer
    }

    _Result operator()(_Arg _Left) const { // call function with operand
        return _Pfun(_Left);
    }

protected:
    _Fn _Pfun; // the function pointer
};

class Foundation_API TraverseBase
{
public:
	typedef std::stack<DirectoryIterator> Stack;
	typedef pointer_to_unary_function<const Stack&, UInt16> DepthFunPtr;

	enum
	{
		D_INFINITE = 0 /// Special value for infinite traverse depth.
	};

	TraverseBase(DepthFunPtr depthDeterminer, UInt16 maxDepth = D_INFINITE);

protected:
	bool isFiniteDepth();
	bool isDirectory(Poco::File& file);

	DepthFunPtr _depthDeterminer;
	UInt16 _maxDepth;
	DirectoryIterator _itEnd;

private:
	TraverseBase();
	TraverseBase(const TraverseBase&);
	TraverseBase& operator=(const TraverseBase&);
};


class Foundation_API ChildrenFirstTraverse: public TraverseBase
{
public:
	ChildrenFirstTraverse(DepthFunPtr depthDeterminer, UInt16 maxDepth = D_INFINITE);

	const std::string next(Stack* itStack, bool* isFinished);

private:
	ChildrenFirstTraverse();
	ChildrenFirstTraverse(const ChildrenFirstTraverse&);
	ChildrenFirstTraverse& operator=(const ChildrenFirstTraverse&);
};


class Foundation_API SiblingsFirstTraverse: public TraverseBase
{
public:
	SiblingsFirstTraverse(DepthFunPtr depthDeterminer, UInt16 maxDepth = D_INFINITE);

	const std::string next(Stack* itStack, bool* isFinished);

private:
	SiblingsFirstTraverse();
	SiblingsFirstTraverse(const SiblingsFirstTraverse&);
	SiblingsFirstTraverse& operator=(const SiblingsFirstTraverse&);

	std::stack<std::queue<std::string> > _dirsStack;
};


} // namespace Poco


#endif // Foundation_RecursiveDirectoryIteratorStrategy_INCLUDED
