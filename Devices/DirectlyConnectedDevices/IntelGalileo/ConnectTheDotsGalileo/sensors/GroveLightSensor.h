//  ---------------------------------------------------------------------------------
//  Copyright (c) Microsoft Open Technologies, Inc.  All rights reserved.
// 
//  The MIT License (MIT)
// 
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
// 
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
// 
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  ---------------------------------------------------------------------------------

#pragma once

#ifndef GROVELIGHTSENSOR_H_
#define GROVELIGHTSENSOR_H_

#include <string>
#include "ISensor.h"
#include "..\grove\GroveLight.h"

#define GROVELIGHTSENSOR_NAME "GroveLightSensor"

class GroveLightSensor : public ISensor 
{
public:
	GroveLightSensor(int pin)
		: m_pin(pin), m_name(GROVELIGHTSENSOR_NAME)
	{

	}

	virtual ~GroveLightSensor() 
	{
		if (m_light != NULL)
			delete m_light;
	}

	std::string const &name() const
	{
		return (m_name);
	}

	double value() 
	{
		if (m_light == NULL)
			_init();
		return (static_cast<double>(m_light->inLux()));
	}
private:
	void _init() {
		m_light = new grove::Light(m_pin);
	}

	int				m_pin;
	std::string		m_name;
	grove::Light	*m_light = NULL;
};

#endif // GROVETEMPERATURESENSOR_H_