//
// Copyright (C) 2013-2021 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick			2.8
import QtQuick.Layouts	1.3
import JASP.Controls	1.0
import JASP.Widgets		1.0

import "./common/ui" as UI
import "./common/tables" as TAB
import "./common/figures" as FIG
import "./common/analyses/svm" as SVM

Form
{
	info: qsTr("Support Vector Machines is a supervised learning algorithm that maps training examples to points in space so as to maximise the width of the gap between the two categories. New examples are then mapped into that same space and predicted to belong to a category based on which side of the gap they fall.\n### Assumptions\n- The target is a nominal or ordinal variable.\n- The feature variables consist of continuous, nominal, or ordinal variables.")

	UI.VariablesFormClassification { id: vars }

	Group
	{
		title: qsTr("Tables")

		TAB.ConfusionMatrix { }
		TAB.ClassProportions { }
		TAB.ModelPerformance { }
		TAB.FeatureImportance { }
		TAB.ExplainPredictions { }
		SVM.SupportVectors { }
	}

	Group
	{
		title: qsTr("Plots")

		FIG.DataSplit { }
		FIG.RocCurve { }
		FIG.AndrewsCurve { }
		SVM.OptimPlot { regression: false; enable: !optim.isManual }
		FIG.DecisionBoundary { }
	}

	UI.ExportResults { enabled: vars.predictorCount > 0 && vars.targetCount > 0 }
	UI.DataSplit { leaveOneOutVisible: false; kFoldsVisible: false; trainingValidationSplit: !optim.isManual }

	Section
	{
		title: qsTr("Training Parameters")

		Group
		{
			title: qsTr("Algorithmic Settings")

			SVM.AlgorithmicSettings { }
			UI.ScaleVariables { }
			UI.SetSeed { }
		}

		SVM.ModelOptimization { id: optim }
	}
}
